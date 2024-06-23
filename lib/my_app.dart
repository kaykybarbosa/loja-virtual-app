import 'package:flutter/material.dart';
import 'package:lojavirtualapp/models/user_manager.dart';
import 'package:lojavirtualapp/routes/app_pages.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/theme_data/app_bar_theme.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserManager()),
        ],
        child: MaterialApp.router(
          title: 'Loja do Kbuloso',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: MyColors.primary,
            scaffoldBackgroundColor: MyColors.primary,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: TAppBarTheme.light,
            colorScheme: const ColorScheme.light(primary: MyColors.primary),
            textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: MyColors.base100,
                backgroundColor: MyColors.primary,
              ),
            ),
          ),
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      );
}
