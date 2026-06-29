import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/store_manager.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/ui/screens/stores/widgets/store_card.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';
import 'package:provider/provider.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(title: const Text('Lojas')),
      body: Consumer<StoreManager>(
        builder: (_, storeManager, _) {
          if (storeManager.isLoading) {
            return LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.base100),
              backgroundColor: Colors.transparent,
            );
          }

          return ListView.builder(
            itemCount: storeManager.stores.length,
            itemBuilder: (_, i) {
              return StoreCard(store: storeManager.stores[i]);
            },
          );
        },
      ),
    );
  }
}
