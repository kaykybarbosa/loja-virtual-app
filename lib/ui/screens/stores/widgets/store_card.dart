import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/domain/enums/store_enum.dart';
import 'package:lojavirtualapp/domain/models/store_model.dart';
import 'package:lojavirtualapp/ui/common/custom_icon_button.dart';
import 'package:lojavirtualapp/utils/messages/custom_snackbar.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key, required this.store});

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    Color colorFromStatus(StoreStatus status) {
      switch (status) {
        case StoreStatus.closed:
          return AppColors.warn;
        case StoreStatus.open:
          return AppColors.green;
        case StoreStatus.closing:
          return AppColors.orange;
      }
    }

    void snackBar() {
      customSnackbar(
        context,
        message: 'Este dispositivo não possui esta função.',
        type: AnimatedSnackBarType.warning,
      );
    }

    Future<void> openPhone() async {
      final url = Uri(scheme: 'tel', path: store.cleanPhone);

      if (await canLaunchUrl(url)) {
        launchUrl(url);
      } else {
        snackBar();
      }
    }

    Future<void> openMap() async {
      try {
        final availableMaps = await MapLauncher.installedMaps;

        showModalBottomSheet(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (_) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final map in availableMaps)
                    ListTile(
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(map.icon, width: 30),
                      onTap: () {
                        map.showMarker(
                          coords: Coords(store.address.lat, store.address.long),
                          title: store.name,
                          description: store.addressText,
                        );

                        context.pop();
                      },
                    ),
                ],
              ),
            );
          },
        );
      } catch (e) {
        snackBar();
      }
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Imagem
                Image.network(store.image, fit: BoxFit.cover),

                // Status
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.base100,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                    ),
                    child: Text(
                      store.statusText,
                      style: TextStyle(
                        color: colorFromStatus(store.status),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

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
                      onTap: openMap,
                    ),

                    CustomIconButton(
                      icon: Icons.phone,
                      color: AppColors.primary,
                      onTap: openPhone,
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
