import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/routes/app_pages.dart';
import 'package:lojavirtualapp/dependencies/app_providers.dart';
import 'package:lojavirtualapp/utils/theme/theme_data/theme_data.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: AppProviders.providers,
        child: MaterialApp.router(
          title: 'Loja do Kbuloso',
          theme: TThemeData.light,
          routerConfig: routerConfig,
          debugShowCheckedModeBanner: false,
        ),
      );
}
