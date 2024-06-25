import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lojavirtualapp/domain/models/section_model.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/item_tile.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/section_header.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section, {super.key});

  final SectionModel section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section: section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final image = section.items[index].image;

                return ItemTile(image: image);
              },
              separatorBuilder: (_, __) => const Gap(4),
              itemCount: section.items.length,
            ),
          )
        ],
      ),
    );
  }
}
