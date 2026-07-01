import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Icone
              Icon(
                Icons.account_circle,
                size: 100,
                color: Theme.of(context).primaryColor,
              ),

              // Texto
              Text(
                'Faça o login para acessar os produtos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              // Botão
              ElevatedButton(
                onPressed: () {
                  context.push(AppRoutes.login);
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
