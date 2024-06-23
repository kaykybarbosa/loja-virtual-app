import 'package:flutter/material.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer_header.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/drawer_tile.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';

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
                  icon: Icons.home,
                ),
                const DrawerTile(
                  page: 1,
                  title: 'Produtos',
                  icon: Icons.list,
                ),
                const DrawerTile(
                  page: 2,
                  title: 'Meus pedidos',
                  icon: Icons.playlist_add_check,
                ),
                const DrawerTile(
                  page: 3,
                  title: 'Lojas',
                  icon: Icons.location_on,
                ),
              ],
            ),
          ],
        ),
      );
}
