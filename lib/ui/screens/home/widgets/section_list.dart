import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lojavirtualapp/data/managers/home_manager.dart';
import 'package:lojavirtualapp/domain/models/section_model.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/add_title_widget.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/item_tile.dart';
import 'package:lojavirtualapp/ui/screens/home/widgets/section_header.dart';
import 'package:provider/provider.dart';

class SectionList extends StatefulWidget {
  const SectionList(this.section, {super.key});

  final SectionModel section;

  @override
  State<SectionList> createState() => _SectionListState();
}

class _SectionListState extends State<SectionList> {
  @override
  void initState() {
    super.initState();

    log('INIT', name: 'FIX');
  }

  @override
  void dispose() {
    super.dispose();

    log('DISPOSED', name: 'FIX');
  }

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    log(widget.section.toString(), name: 'FIX');

    return ChangeNotifierProvider.value(
      value: widget.section,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SectionHeader(),
            SizedBox(
              height: 150,
              child: Consumer<SectionModel>(
                builder: (_, sectionModel, __) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      if (index < sectionModel.items.length) {
                        final item = sectionModel.items[index];

                        return ItemTile(item: item);
                      } else {
                        return const AddTitleWidget();
                      }
                    },
                    separatorBuilder: (_, __) => const Gap(4),
                    itemCount: homeManager.editing ? sectionModel.items.length + 1 : sectionModel.items.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
