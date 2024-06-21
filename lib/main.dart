import 'package:flutter/material.dart';
import 'package:lojavirtualapp/screens/base/base_screen.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/theme_data/app_bar_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Loja do Kbuloso',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: MyColors.primary,
          scaffoldBackgroundColor: MyColors.primary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: TAppBarTheme.light,
        ),
        debugShowCheckedModeBanner: false,
        home: BaseScreen(),
      );
}
