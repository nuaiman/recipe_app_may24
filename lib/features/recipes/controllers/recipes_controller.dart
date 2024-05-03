import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/recipes_api.dart';
import '../../../models/recipe_details.dart';

class RecipesNotifier extends StateNotifier<List<RecipeDetails>> {
  final RecipesApi _recipesApi;
  RecipesNotifier({required RecipesApi recipesApi})
      : _recipesApi = recipesApi,
        super([]);

  Future<void> searchRecipes(String query) async {
    state = [];
    final recipes = await _recipesApi.searchRecipes(query);

    final List<RecipeDetails> recipeDetailsList = [];
    for (final recipe in recipes) {
      final recipeDetails = await _recipesApi.getRecipeDetails(recipe.id);
      recipeDetailsList.add(recipeDetails);
      state = [...state, recipeDetails];
    }

    // state = recipeDetailsList;
  }
}
// -----------------------------------------------------------------------------

final recipesProvider =
    StateNotifierProvider<RecipesNotifier, List<RecipeDetails>>((ref) {
  final recipesApi = ref.watch(recipesApiProvider);
  return RecipesNotifier(recipesApi: recipesApi);
});
