import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/section_model.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.section});

  final SectionModel section;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          section.name,
          style: const TextStyle(
            fontSize: 18,
            color: MyColors.base100,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
}
