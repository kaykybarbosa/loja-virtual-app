import 'package:flutter/material.dart';
import 'package:lojavirtualapp/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/models/page_manager.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(_controller),
      child: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(title: const Text('Início')),
            body: Container(),
          ),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(title: const Text('Produtos')),
            body: Container(),
          ),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(title: const Text('Meus pedidos')),
            body: Container(),
          ),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(title: const Text('Lojas')),
            body: Container(),
          ),
        ],
      ),
    );
  }
}
