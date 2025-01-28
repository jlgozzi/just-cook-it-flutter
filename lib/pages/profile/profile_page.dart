import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user data (será substituído por dados reais do Firebase futuramente)
    const String userName = "Usuário Exemplo";
    const String userEmail = "usuario@email.com";
    const String userPhotoUrl = ""; // Deixe vazio para exibir um avatar padrão

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto de perfil
              CircleAvatar(
                radius: 60.0,
                backgroundImage: userPhotoUrl.isNotEmpty
                    ? const NetworkImage(userPhotoUrl)
                    : null,
                child: userPhotoUrl.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 60.0,
                      )
                    : null,
              ),
              const SizedBox(height: 16.0),
              // Nome do usuário
              const Text(
                userName,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              // Email do usuário
              const Text(
                userEmail,
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const SizedBox(height: 24.0),
              // Botão de editar informações
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _EditProfileModal(
                      initialName: userName,
                      onSave: (newName) {
                        // Lógica para salvar o novo nome (será integrado com o Firebase)
                        print("Novo nome salvo: $newName");
                      },
                    ),
                  );
                },
                child: const Text('Editar Perfil'),
              ),
              const SizedBox(height: 16.0),
              // Botão para voltar
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Componente reutilizável: Modal para editar o perfil
class _EditProfileModal extends StatefulWidget {
  final String initialName;
  final Function(String) onSave;

  const _EditProfileModal({
    super.key,
    required this.initialName,
    required this.onSave,
  });

  @override
  State<_EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<_EditProfileModal> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Perfil'),
      content: TextField(
        controller: _nameController,
        decoration: const InputDecoration(labelText: 'Nome'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave(_nameController.text);
            Navigator.pop(context);
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
