import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      );
}
