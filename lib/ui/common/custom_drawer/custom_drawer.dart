import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer_header.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/drawer_tile.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  MyColors.gradient,
                  MyColors.base100,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
            ListView(
              children: <Widget>[
                const CustomDrawerHeader(),
                Divider(color: MyColors.base100.withAlpha(100)),
                const DrawerTile(
                  page: 0,
                  title: 'Início',
                  icon: MyIcons.home,
                ),
                const DrawerTile(
                  page: 1,
                  title: 'Produtos',
                  icon: Icons.list,
                ),
                const DrawerTile(
                  page: 2,
                  title: 'Meus pedidos',
                  icon: MyIcons.listCheck,
                ),
                const DrawerTile(
                  page: 3,
                  title: 'Lojas',
                  icon: MyIcons.location,
                ),
                Consumer<UserManager>(
                  builder: (_, userManager, __) {
                    if (userManager.adminEnabled) {
                      return Column(
                        children: <Widget>[
                          Divider(color: MyColors.base100.withAlpha(100)),
                          const DrawerTile(
                            page: 4,
                            title: 'Usuários',
                            icon: MyIcons.users,
                          ),
                          const DrawerTile(
                            page: 5,
                            title: 'Pedidos',
                            icon: MyIcons.settings,
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ],
        ),
      );
}
