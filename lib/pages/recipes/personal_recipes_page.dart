// import 'package:flutter/material.dart';
// import 'package:just_cook_it/services/recipes_service.dart';
// import 'package:just_cook_it/components/modals/recipes/add_recipe_modal.dart';
// import 'package:just_cook_it/components/modals/recipes/update_recipe_modal.dart';

// class PersonalRecipesPage extends StatefulWidget {
//   const PersonalRecipesPage({super.key});

//   @override
//   State<PersonalRecipesPage> createState() => _PersonalRecipesPageState();
// }

// class _PersonalRecipesPageState extends State<PersonalRecipesPage> {
//   final RecipeService _recipeService = RecipeService();
//   final List<Map<String, dynamic>> _recipes = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchRecipes();
//   }

//   Future<void> _fetchRecipes() async {
//     try {
//       // final recipes = await _recipeService.fetchRecipes();
//       setState(() {
//         // _recipes = recipes;
//       });
//     } catch (e) {
//       debugPrint('Erro ao buscar receitas: $e');
//     }
//   }

//   Future<void> _addRecipe(Map<String, dynamic> newRecipe) async {
//     try {
//       await _recipeService.createRecipe(newRecipe);
//       _fetchRecipes();
//     } catch (e) {
//       debugPrint('Erro ao adicionar receita: $e');
//     }
//   }

//   Future<void> _updateRecipe(
//       String recipeId, Map<String, dynamic> updatedRecipe) async {
//     try {
//       await _recipeService.updateRecipe(recipeId, updatedRecipe);
//       _fetchRecipes();
//     } catch (e) {
//       debugPrint('Erro ao atualizar receita: $e');
//     }
//   }

//   Future<void> _deleteRecipe(String recipeId) async {
//     try {
//       await _recipeService.deleteRecipe(recipeId);
//       _fetchRecipes();
//     } catch (e) {
//       debugPrint('Erro ao excluir receita: $e');
//     }
//   }

//   void _openAddRecipeModal() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => AddRecipeModal(
//         onSave: (newRecipe) async {
//           await _addRecipe(newRecipe);
//           Navigator.pop(context); // Fechar o modal após salvar
//         },
//       ),
//     );
//   }

//   void _openUpdateRecipeModal(
//       String recipeId, Map<String, dynamic> currentRecipe) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => UpdateRecipeModal(
//         recipe: currentRecipe,
//         onSave: (updatedRecipe) async {
//           await _updateRecipe(recipeId, updatedRecipe);
//           Navigator.pop(context); // Fechar o modal após atualizar
//         },
//       ),
//     );
//   }

//   void _openDeleteRecipeModal(String recipeId) {
//     showDialog(
//       context: context,
//       builder: (context) => DeleteRecipeModal(
//         onDelete: () async {
//           await _deleteRecipe(recipeId);
//           Navigator.pop(context); // Fechar o modal após excluir
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Minhas Receitas'),
//       ),
//       body: _recipes.isEmpty
//           ? const Center(
//               child: Text(
//                 'Nenhuma receita cadastrada.',
//                 style: TextStyle(fontSize: 16.0),
//               ),
//             )
//           : ListView.builder(
//               itemCount: _recipes.length,
//               itemBuilder: (context, index) {
//                 final recipe = _recipes[index];
//                 return Card(
//                   margin: const EdgeInsets.all(8.0),
//                   child: ListTile(
//                     title: Text(recipe['name']),
//                     subtitle: Text(
//                         'Tempo de preparo: ${recipe['preparationTime']} minutos\nComplexidade: ${recipe['complexity']}'),
//                     isThreeLine: true,
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () =>
//                               _openUpdateRecipeModal(recipe['id'], recipe),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () => _openDeleteRecipeModal(recipe['id']),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _openAddRecipeModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
