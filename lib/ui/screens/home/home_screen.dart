import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/home_manager.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/domain/models/section_model.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/section_list.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/section_staggered.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const CustomDrawer(),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    MyColors.gradientHome1,
                    MyColors.gradientHome2,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            CustomScrollView(
              slivers: <Widget>[
                /// AppBar
                SliverAppBar(
                  snap: true,
                  floating: true,
                  scrolledUnderElevation: 0,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: const FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'Loja do Kbuloso',
                      style: TextStyle(color: MyColors.base100),
                    ),
                  ),
                  actions: <Widget>[
                    /// -- Carrinho
                    IconButton(
                      onPressed: () => context.push(AppRoutes.cart),
                      icon: const Icon(MyIcons.cart),
                    ),

                    /// -- Editar
                    Consumer2<UserManager, HomeManager>(
                      builder: (_, user, home, __) {
                        if (user.adminEnabled && !home.savingSections) {
                          if (home.editing) {
                            return PopupMenuButton(
                              onSelected: (value) {
                                if (value == 'Salvar') {
                                  home.saveEditing();
                                } else {
                                  home.discardEditing();
                                }
                              },
                              itemBuilder: (_) => ['Salvar', 'Descartar']
                                  .map(
                                    (option) => PopupMenuItem(
                                      value: option,
                                      child: Text(option),
                                    ),
                                  )
                                  .toList(),
                            );
                          } else {
                            return IconButton(
                              icon: const Icon(MyIcons.edit),
                              onPressed: home.enterEditing,
                            );
                          }
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
                  ],
                ),

                /// Info
                Consumer<HomeManager>(
                  builder: (_, homeManager, __) => homeManager.savingSections || homeManager.isLoading
                      ? const SliverToBoxAdapter(
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(MyColors.base100),
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) {
                              final section = homeManager.sections[index];
                              final type = section.type;

                              return switch (type) {
                                'List' => SectionList(section),
                                'Staggered' => SectionStaggered(section),
                                _ => Container(),
                              };
                            },
                            childCount: homeManager.sections.length,
                          ),
                        ),
                ),

                const AddSectionWidget()
              ],
            ),
          ],
        ),
      );
}

class AddSectionWidget extends StatelessWidget {
  const AddSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return SliverVisibility(
      visible: homeManager.editing && !homeManager.savingSections,
      sliver: SliverToBoxAdapter(
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: const ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(MyColors.base100),
                ),
                onPressed: () => homeManager.addSection(SectionModel(type: 'List')),
                child: const Text('Adicionar Lista'),
              ),
            ),
            Expanded(
              child: TextButton(
                style: const ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(MyColors.base100),
                ),
                onPressed: () => homeManager.addSection(SectionModel(type: 'Staggered')),
                child: const Text('Adicionar Grade'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
