import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/recipe_details.dart';
import 'recipe_list_item.dart';

class RecipeListBuilder extends StatelessWidget {
  const RecipeListBuilder({
    super.key,
    required this.recipes,
    required this.ref,
  });

  final List<RecipeDetails> recipes;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipeListItem(recipe: recipe, ref: ref);
        });
  }
}
