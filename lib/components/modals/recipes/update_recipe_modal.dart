import 'package:flutter/material.dart';
import 'package:just_cook_it/services/recipes_service.dart';

class UpdateRecipeModal extends StatefulWidget {
  final RecipeService recipeService;
  final Map<String, dynamic> recipeData;

  const UpdateRecipeModal({
    super.key,
    required this.recipeService,
    required this.recipeData,
  });

  @override
  State<UpdateRecipeModal> createState() => _UpdateRecipeModalState();
}

class _UpdateRecipeModalState extends State<UpdateRecipeModal> {
  final _formKey = GlobalKey<FormState>();
  late String recipeName;
  late String ingredients;
  late String preparationMethod;
  late String preparationTime;
  late int complexity;

  @override
  void initState() {
    super.initState();
    recipeName = widget.recipeData['name'];
    ingredients = widget.recipeData['ingredients'];
    preparationMethod = widget.recipeData['preparationMethod'];
    preparationTime = widget.recipeData['preparationTime'];
    complexity = widget.recipeData['complexity'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Atualizar Receita',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  initialValue: recipeName,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obrigatório'
                      : null,
                  onSaved: (value) => recipeName = value ?? '',
                ),
                TextFormField(
                  initialValue: ingredients,
                  decoration: const InputDecoration(labelText: 'Ingredientes'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obrigatório'
                      : null,
                  onSaved: (value) => ingredients = value ?? '',
                ),
                TextFormField(
                  initialValue: preparationMethod,
                  decoration:
                      const InputDecoration(labelText: 'Modo de preparo'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obrigatório'
                      : null,
                  onSaved: (value) => preparationMethod = value ?? '',
                ),
                TextFormField(
                  initialValue: preparationTime,
                  decoration: const InputDecoration(
                      labelText: 'Tempo de preparo (minutos)'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obrigatório'
                      : null,
                  onSaved: (value) => preparationTime = value ?? '',
                ),
                DropdownButtonFormField<int>(
                  value: complexity,
                  decoration: const InputDecoration(labelText: 'Complexidade'),
                  items: List.generate(
                    5,
                    (index) => DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text('Nível ${index + 1}'),
                    ),
                  ),
                  onChanged: (value) => complexity = value ?? 1,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        await widget.recipeService.updateRecipe(
                          recipeId: widget.recipeData['id'],
                          name: recipeName,
                          ingredients: ingredients,
                          preparationMethod: preparationMethod,
                          preparationTime: preparationTime,
                          complexity: complexity,
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Erro ao atualizar: \$e')),
                        );
                      }
                    }
                  },
                  child: const Text('Atualizar Receita'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
