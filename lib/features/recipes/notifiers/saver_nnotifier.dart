// import 'dart:convert';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:recipes_app_may24/models/recipe_details.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SaverNotifier extends StateNotifier<List<RecipeDetails>> {
//   SaverNotifier() : super([]);

//   Future<void> saveOrRemoveRecipe(RecipeDetails recipe, int id) async {
//     final prefs = await SharedPreferences.getInstance();
//     final encodedRecipe = json.encode(recipe.toJson());

//     if (state.any((element) => element.id == id)) {
//       await prefs.remove(id.toString());
//       state = List.from(state)..removeWhere((recipe) => recipe.id == id);
//     } else {
//       await prefs.setString(id.toString(), encodedRecipe);
//       state = List.from(state)..add(recipe);
//     }
//   }

//   Future<void> getAllRecipes() async {
//     final prefs = await SharedPreferences.getInstance();
//     final allKeys = prefs.getKeys();
//     final List<RecipeDetails> recipes = [];
//     for (final key in allKeys) {
//       final encodedRecipe = prefs.getString(key);
//       if (encodedRecipe != null) {
//         final Map<String, dynamic> decodedRecipe = json.decode(encodedRecipe);
//         recipes.add(RecipeDetails.fromJson(decodedRecipe));
//       }
//     }

//     state = recipes;
//   }

//   bool containsRecipe(int id) {
//     return state.any((recipe) => recipe.id == id);
//   }
// }
// // -----------------------------------------------------------------------------

// final saverProvider =
//     StateNotifierProvider<SaverNotifier, List<RecipeDetails>>((ref) {
//   return SaverNotifier();
// });
