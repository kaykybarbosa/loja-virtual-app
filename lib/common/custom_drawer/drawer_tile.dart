import 'package:flutter/material.dart';
import 'package:lojavirtualapp/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.page,
    required this.title,
    required this.icon,
  });

  final int page;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final curPage = context.watch<PageManager>().page;

    return InkWell(
      onTap: () => context.read<PageManager>().setPage(page),
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            /// Ícone
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                icon,
                size: 32,
                color: curPage == page ? Colors.blue[700] : Colors.grey[700],
              ),
            ),

            /// Título
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ? Colors.blue[700] : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
