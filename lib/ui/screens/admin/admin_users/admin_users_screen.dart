import 'package:alphabet_list_scroll_view_fix/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/admin_orders_manager.dart';
import 'package:lojavirtualapp/data/managers/admin_users_manager.dart';
import 'package:lojavirtualapp/data/managers/page_manager.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(centerTitle: true, title: const Text('Usuários')),
      body: Consumer<AdminUsersManager>(
        builder: (_, userManager, _) {
          return AlphabetListScrollView(
            showPreview: true,
            keyboardUsage: true,
            indexedHeight: (_) => 80,
            strList: userManager.strUsers,
            highlightTextStyle: const TextStyle(fontSize: 20, color: AppColors.base100),
            itemBuilder: (_, index) {
              final UserModel user = userManager.users[index];

              return ListTile(
                title: Text(
                  user.fullName.capitalizeAll,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.base100,
                  ),
                ),
                subtitle: Text(
                  user.email,
                  style: const TextStyle(color: AppColors.base100),
                ),
                onTap: () {
                  context.read<AdminOrdersManager>().userFilter = user;
                  context.read<PageManager>().setPage(5);
                },
              );
            },
          );
        },
      ),
    );
  }
}
