import 'package:flutter/material.dart';
import 'package:just_cook_it/pages/profile/profile_page.dart';
import 'package:just_cook_it/pages/recipes/personal_recipes_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Bem-vindo(a)!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Escolha uma opção abaixo:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
                child: const Text('Minhas Receitas'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Redirecionar para uma tela de listagem de todas as receitas (ainda a ser criada).
                },
                child: const Text('Listar Receitas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
