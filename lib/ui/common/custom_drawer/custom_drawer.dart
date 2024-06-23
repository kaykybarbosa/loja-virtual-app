import 'package:flutter/material.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: const [
            DrawerTile(
              page: 0,
              title: 'Início',
              icon: Icons.home,
            ),
            DrawerTile(
              page: 1,
              title: 'Produtos',
              icon: Icons.list,
            ),
            DrawerTile(
              page: 2,
              title: 'Meus pedidos',
              icon: Icons.playlist_add_check,
            ),
            DrawerTile(
              page: 3,
              title: 'Lojas',
              icon: Icons.location_on,
            ),
          ],
        ),
      );
}
