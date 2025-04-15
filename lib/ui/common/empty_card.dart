import 'package:flutter/material.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// Ícone
            Icon(
              icon,
              size: 80.0,
              color: MyColors.base100,
            ),

            /// Título
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: MyColors.base100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
