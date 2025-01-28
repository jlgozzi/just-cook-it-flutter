import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Referência à coleção de receitas no Firestore
  CollectionReference get _recipesCollection =>
      _firestore.collection('recipes');

  /// Cria uma nova receita no Firestore
  Future<void> createRecipe({
    required String name,
    required String ingredients,
    required String preparationMethod,
    required String preparationTime,
    required int complexity,
  }) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    await _recipesCollection.add({
      'name': name,
      'ingredients': ingredients,
      'preparationMethod': preparationMethod,
      'preparationTime': preparationTime,
      'complexity': complexity,
      'userId': user.uid, // Adiciona o identificador do usuário
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Atualiza uma receita existente
  Future<void> updateRecipe({
    required String recipeId,
    required String name,
    required String ingredients,
    required String preparationMethod,
    required String preparationTime,
    required int complexity,
  }) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    final doc = await _recipesCollection.doc(recipeId).get();

    if (!doc.exists || doc['userId'] != user.uid) {
      throw Exception('Permissão negada ou receita não encontrada.');
    }

    await _recipesCollection.doc(recipeId).update({
      'name': name,
      'ingredients': ingredients,
      'preparationMethod': preparationMethod,
      'preparationTime': preparationTime,
      'complexity': complexity,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Deleta uma receita existente
  Future<void> deleteRecipe(String recipeId) async {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    final doc = await _recipesCollection.doc(recipeId).get();

    if (!doc.exists || doc['userId'] != user.uid) {
      throw Exception('Permissão negada ou receita não encontrada.');
    }

    await _recipesCollection.doc(recipeId).delete();
  }

  /// Busca todas as receitas do usuário autenticado
  Stream<List<Map<String, dynamic>>> getUserRecipes() {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    return _recipesCollection
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              };
            }).toList());
  }
}
