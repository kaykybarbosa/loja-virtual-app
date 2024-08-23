import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lojavirtualapp/data/managers/home_manager.dart';
import 'package:lojavirtualapp/domain/models/section_item_model.dart';
import 'package:lojavirtualapp/domain/models/section_model.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/add_title_widget.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/item_tile.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/section_header.dart';
import 'package:provider/provider.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered(this.section, {super.key});

  final SectionModel section;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    const item = SectionItemModel();

    if (homeManager.editing && !section.items.contains(item)) {
      section.items.add(item);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section: section),
          StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: section.items.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final item = entry.value;

                final isLast = section.items.last == item;

                return StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: index.isEven ? 2 : 1,
                  child: homeManager.editing && isLast ? const AddTitleWidget() : ItemTile(item: item),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
