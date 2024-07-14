import 'package:alphabet_list_scroll_view_fix/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/admin_users_manager.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Usuários'),
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, userManager, __) {
          return AlphabetListScrollView(
            showPreview: true,
            keyboardUsage: true,
            highlightTextStyle: const TextStyle(
              color: MyColors.base100,
              fontSize: 20,
            ),
            strList: userManager.strUsers,
            indexedHeight: (_) {
              return 80;
            },
            itemBuilder: (_, index) {
              final user = userManager.users[index];
              return ListTile(
                title: Text(
                  user.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: MyColors.base100,
                  ),
                ),
                subtitle: Text(
                  user.email,
                  style: const TextStyle(
                    color: MyColors.base100,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
