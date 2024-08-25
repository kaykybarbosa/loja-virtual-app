import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lojavirtualapp/data/managers/home_manager.dart';
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

    return ChangeNotifierProvider(
      create: (_) => section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionHeader(),
            Consumer<SectionModel>(
              builder: (_, sectionModel, __) {
                return StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: sectionModel.items.asMap().entries.map<Widget>(
                    (entry) {
                      final index = entry.key;
                      final item = entry.value;

                      return StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: index.isEven ? 2 : 1,
                        child: ItemTile(item: item),
                      );
                    },
                  ).toList()
                    ..add(
                      homeManager.editing
                          ? StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: sectionModel.items.length.isEven ? 2 : 1,
                              child: const AddTitleWidget(),
                            )
                          : const SizedBox(),
                    ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
