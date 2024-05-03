import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:recipes_app_may24/constants/api_constants.dart';

import '../models/recipe.dart';
import '../models/recipe_details.dart';

abstract class IRecipesApi {
  Future<List<Recipe>> searchRecipes(String query);
  Future<RecipeDetails> getRecipeDetails(int id);
}
// -----------------------------------------------------------------------------

class RecipesApi implements IRecipesApi {
  @override
  Future<List<Recipe>> searchRecipes(String query) async {
    final url = '${ApiConstants.baseUrl}$query';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': ApiConstants.rapidApiKey,
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> recipeData = jsonData['results'];
      List<Recipe> recipes =
          recipeData.map((data) => Recipe.fromMap(data)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  @override
  Future<RecipeDetails> getRecipeDetails(int id) async {
    final url =
        'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/$id/information';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': ApiConstants.rapidApiKey,
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      RecipeDetails recipeDetails = RecipeDetails.fromJson(jsonData);

      return recipeDetails;
    } else {
      throw Exception('Failed to load recipe details');
    }
  }
}
// -----------------------------------------------------------------------------

final recipesApiProvider = Provider<RecipesApi>((ref) {
  return RecipesApi();
});
