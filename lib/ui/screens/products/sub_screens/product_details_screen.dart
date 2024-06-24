import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/ui/common/submit_form_button.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/widgets/size_widget.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen(this.product, {super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: MyColors.base100,
        appBar: AppBar(
          centerTitle: true,
          title: Text(product.name),
        ),
        body: ListView(
          children: <Widget>[
            /// Imagens
            FlutterCarousel.builder(
              itemCount: product.images.length,
              itemBuilder: (_, index, __) => AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  product.images[index],
                  fit: BoxFit.cover,
                ),
              ),
              options: CarouselOptions(
                height: 300,
                slideIndicator: CircularSlideIndicator(
                  currentIndicatorColor: MyColors.primary,
                  indicatorBackgroundColor: MyColors.base400,
                  indicatorRadius: 4,
                  itemSpacing: 15,
                ),
              ),
            ),

            /// Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// -- Nome
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  /// -- A partir
                  const Text(
                    'A partir de',
                    style: TextStyle(
                      fontSize: 14,
                      color: MyColors.base500,
                    ),
                  ),

                  /// -- Preço
                  const Text(
                    'R\$ 19.99',
                    style: TextStyle(
                      fontSize: 22,
                      color: MyColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// -- Descrição
                  const _SubTitle('Descrição'),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  /// -- Tamanhos
                  const _SubTitle('Tamanhos'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.sizes.map((size) => SizeWidget(size)).toList(),
                  ),

                  const Gap(16),

                  /// -- Botão
                  if (product.hasStock)
                    Consumer2<UserManager, ProductModel>(builder: (_, user, productManager, __) {
                      return SubmitFormButton(
                        width: double.infinity,
                        onPressed: productManager.getSelectedSize != null
                            ? () {
                                if (user.currentUserIsAuth) {
                                  context.read<CartManager>().addToCart(productManager);
                                  context.push(AppRoutes.cart);
                                } else {
                                  context.push(AppRoutes.login);
                                }
                              }
                            : null,
                        text: user.currentUserIsAuth ? 'Adicionar ao carrinho' : 'Entre para comprar',
                      );
                    })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
