import 'package:flutter/material.dart';
import 'package:just_cook_it/services/recipes_service.dart';

class DeleteRecipeModal extends StatelessWidget {
  final RecipeService recipeService;
  final String recipeId;

  const DeleteRecipeModal({
    super.key,
    required this.recipeService,
    required this.recipeId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Excluir Receita'),
      content: const Text('Você tem certeza que deseja excluir esta receita?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              await recipeService.deleteRecipe(recipeId);
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao excluir: \$e')),
              );
            }
          },
          child: const Text('Excluir'),
        ),
      ],
    );
  }
}
