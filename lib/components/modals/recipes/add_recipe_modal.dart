import 'package:flutter/material.dart';
import 'package:just_cook_it/services/recipes_service.dart';

class AddRecipeModal extends StatefulWidget {
  final RecipeService recipeService;

  const AddRecipeModal({super.key, required this.recipeService});

  @override
  State<AddRecipeModal> createState() => _AddRecipeModalState();
}

class _AddRecipeModalState extends State<AddRecipeModal> {
  final _formKey = GlobalKey<FormState>();
  String recipeName = '';
  String ingredients = '';
  String preparationMethod = '';
  String preparationTime = '';
  int complexity = 1;

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
                  'Adicionar Receita',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obrigatório'
                      : null,
                  onSaved: (value) => recipeName = value ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Ingredientes'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obrigatório'
                      : null,
                  onSaved: (value) => ingredients = value ?? '',
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Modo de preparo'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo obrigatório'
                      : null,
                  onSaved: (value) => preparationMethod = value ?? '',
                ),
                TextFormField(
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
                        await widget.recipeService.createRecipe(
                          name: recipeName,
                          ingredients: ingredients,
                          preparationMethod: preparationMethod,
                          preparationTime: preparationTime,
                          complexity: complexity,
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erro ao salvar: \$e')),
                        );
                      }
                    }
                  },
                  child: const Text('Salvar Receita'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
