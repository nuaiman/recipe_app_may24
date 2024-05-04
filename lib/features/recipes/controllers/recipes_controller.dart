// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:recipes_app_may24/core/notifiers/loader_notifier.dart';

// import '../../../apis/recipes_api.dart';
// import '../../../models/recipe_details.dart';

// class RecipesNotifier extends StateNotifier<List<RecipeDetails>> {
//   final RecipesApi _recipesApi;
//   final LoaderNotifier _loader;
//   RecipesNotifier({
//     required RecipesApi recipesApi,
//     required LoaderNotifier loader,
//   })  : _recipesApi = recipesApi,
//         _loader = loader,
//         super([]);

//   void clearState() {
//     state = [];
//     searchRecipes('');
//   }

//   Future<void> searchRecipes(String query) async {
//     state = [];
//     _loader.changeLoaderState(true);
//     final recipes = await _recipesApi.searchRecipes(query);
//     final List<RecipeDetails> recipeDetailsList = [];
//     for (final recipe in recipes) {
//       final recipeDetails = await _recipesApi.getRecipeDetails(recipe.id);
//       recipeDetailsList.add(recipeDetails);
//       state = [...state, recipeDetails];
//     }
//     _loader.changeLoaderState(false);
//     // state = recipeDetailsList;
//   }
// }
// // -----------------------------------------------------------------------------

// final recipesProvider =
//     StateNotifierProvider<RecipesNotifier, List<RecipeDetails>>((ref) {
//   final recipesApi = ref.watch(recipesApiProvider);
//   final loader = ref.watch(loaderProvider.notifier);
//   return RecipesNotifier(
//     recipesApi: recipesApi,
//     loader: loader,
//   );
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app_may24/core/notifiers/loader_notifier.dart';

import '../../../apis/recipes_api.dart';
import '../../../models/recipe_details.dart';

class RecipesNotifier extends StateNotifier<List<RecipeDetails>> {
  final RecipesApi _recipesApi;
  final LoaderNotifier _loader;
  bool _shouldCancel = false;

  RecipesNotifier({
    required RecipesApi recipesApi,
    required LoaderNotifier loader,
  })  : _recipesApi = recipesApi,
        _loader = loader,
        super([]);

  void clearState() {
    _shouldCancel = true;
    state = [];
    _loader.changeLoaderState(false);
  }

  Future<void> searchRecipes(String query) async {
    state = [];
    _loader.changeLoaderState(true);
    _shouldCancel = false;
    final recipes = await _recipesApi.searchRecipes(query);
    final List<RecipeDetails> recipeDetailsList = [];
    for (final recipe in recipes) {
      if (_shouldCancel) {
        state = [];
        return;
      }
      final recipeDetails = await _recipesApi.getRecipeDetails(recipe.id);
      recipeDetailsList.add(recipeDetails);
      state = [...state, recipeDetails];
    }
    _loader.changeLoaderState(false);
  }
}

// -----------------------------------------------------------------------------

final recipesProvider =
    StateNotifierProvider<RecipesNotifier, List<RecipeDetails>>((ref) {
  final recipesApi = ref.watch(recipesApiProvider);
  final loader = ref.watch(loaderProvider.notifier);
  return RecipesNotifier(
    recipesApi: recipesApi,
    loader: loader,
  );
});
