import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registro de novo usuário
  Future<User?> registerUser(
      String email, String password, String fullName) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(fullName);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      throw Exception(e.message);
    }
  }

  // Login de usuário
  Future<User?> loginUser(String email, String password) async {
    try {
      // Tenta fazer login com email e senha
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retorna o usuário logado
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Erro ao fazer login: $e');
      throw Exception(e.message);
    }
  }
}
