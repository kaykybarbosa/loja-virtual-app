import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/home_manager.dart';
import 'package:lojavirtualapp/domain/models/section_model.dart';
import 'package:lojavirtualapp/ui/common/custom_icon_button.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  TextStyle get _style => const TextStyle(
        fontSize: 18,
        color: MyColors.base100,
        fontWeight: FontWeight.w800,
      );

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<SectionModel>();

    if (homeManager.editing) {
      return Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: section.error != null ? 10 : 0),
                  child: TextFormField(
                    initialValue: section.name,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Título',
                      border: InputBorder.none,
                      errorText: section.error,
                    ),
                    style: _style,
                    onChanged: (value) => section.name = value,
                  ),
                ),
              ),
              CustomIconButton(
                icon: MyIcons.remove,
                color: MyColors.base100,
                onTap: () => homeManager.removeSection(section),
                toolTip: 'Remover',
              )
            ],
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          section.name,
          style: _style,
        ),
      );
    }
  }
}
