import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/store_model.dart';
import 'package:lojavirtualapp/ui/common/custom_icon_button.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key, required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          Image.network(store.image),
          Container(
            height: 150,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // Informações
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        store.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        store.addressText,
                        style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),

                      Text(
                        store.openintText,
                        style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),

                // Ícones
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      icon: Icons.map,
                      color: AppColors.primary,
                      onTap: () {},
                    ),

                    CustomIconButton(
                      icon: Icons.phone,
                      color: AppColors.primary,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
