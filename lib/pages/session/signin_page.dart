import 'package:flutter/material.dart';
import 'package:just_cook_it/pages/session/login_page.dart';
import 'package:just_cook_it/services/auth_service.dart';
import 'package:just_cook_it/theme/app_colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isTermsAccepted = false;
  bool _isPasswordVisible = false;
  final bool _isConfirmPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    const pattern = r'^[^@]+@[^@]+\.[^@]+$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Email é obrigatório';
    } else if (!regExp.hasMatch(value)) {
      return 'Insira um email válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    const pattern = r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    } else if (!regExp.hasMatch(value)) {
      return 'A senha deve ter no mínimo 8 caracteres, incluindo 1 número, 1 letra maiúscula e 1 caractere especial';
    }
    return null;
  }

  void _registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final authService = AuthService();
        final user = await authService.registerUser(
          emailController.text,
          passwordController.text,
          fullNameController.text,
        );

        if (user != null) {
          // _showSuccessDialog(); // Mostra diálogo de sucesso
        }
      } catch (e) {
        // _showErrorDialog(e.toString()); // Mostra mensagem de erro
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background, // Cor principal
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary, // Cor dos ícones
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  child: Image.asset('assets/logo1.png'),
                ),
                const SizedBox(height: 24.0),
                const Center(
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary, // Texto principal
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.background, // Fundo do formulário
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          controller: fullNameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome completo',
                            labelStyle: TextStyle(color: AppColors.textPrimary),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.textSecondary),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nome completo é obrigatório';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: AppColors.textPrimary),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.shadow),
                            ),
                          ),
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            labelStyle:
                                const TextStyle(color: AppColors.textPrimary),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.shadow),
                            ),
                          ),
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 16.0),
                        // Outros campos continuam com a mesma lógica de cores...
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
