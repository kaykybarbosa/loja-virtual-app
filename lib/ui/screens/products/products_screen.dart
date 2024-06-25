import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/product_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/ui/screens/products/widgets/product_list_tile.dart';
import 'package:lojavirtualapp/ui/screens/products/widgets/search_dialog.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void setSearch(String search) => context.read<ProductManager>().search = search;

    void cleanSearch() => context.read<ProductManager>().search = '';

    void searchProducts() async {
      final initialValue = context.read<ProductManager>().getSearch;

      final search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(initialValue: initialValue),
      );

      if (search != null) setSearch(search);
    }

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.getSearch.isEmpty) {
              return const Text('Produtos');
            } else {
              return LayoutBuilder(
                builder: (_, contraints) {
                  return GestureDetector(
                    onTap: searchProducts,
                    child: SizedBox(
                      width: contraints.maxWidth,
                      child: Text(
                        productManager.getSearch,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        actions: <Widget>[
          /// Buscar
          Consumer<ProductManager>(
            builder: (_, productManager, __) => IconButton(
              onPressed: productManager.getSearch.isEmpty ? searchProducts : cleanSearch,
              icon: Icon(productManager.getSearch.isEmpty ? MyIcons.search : MyIcons.close),
            ),
          ),
        ],
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final products = productManager.filteredProducts;

          return ListView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.all(4),
            itemBuilder: (_, index) {
              final product = products[index];

              return ProductListTile(product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.cart),
        child: const Icon(MyIcons.cart),
      ),
    );
  }
}
