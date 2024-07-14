import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/page_manager.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 180,
        padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
        child: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                /// Título
                const Text(
                  'Loja do\nKbuloso',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// Usuário atual
                Text(
                  'Olá, ${userManager.getCurrentUser?.fullName ?? ''}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// Sair
                InkWell(
                  onTap: userManager.currentUserIsAuth
                      ? () async => {
                            context.read<PageManager>().setPage(0),
                            await userManager.signOut(),
                          }
                      : () => context.push(AppRoutes.login),
                  child: Text(
                    userManager.currentUserIsAuth ? 'Sair' : 'Entre ou cadastre-se >',
                    style: const TextStyle(
                      color: MyColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
