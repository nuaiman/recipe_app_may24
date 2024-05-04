import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app_may24/features/recipes/notifiers/serving_calculation_notifier.dart';
import 'package:recipes_app_may24/models/recipe_details.dart';

import '../../../core/constants/palette.dart';
import '../notifiers/saver_notifier.dart';
import '../widgets/recipe_details_header.dart';

class RecipeDetailsScreen extends ConsumerWidget {
  final RecipeDetails recipe;
  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(servingCalculationProvider.notifier)
        .setRealServingCount(recipe.serving);
    ref.watch(servingCalculationProvider);
    ref.watch(saverProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            RecipeDetailsHeader(
              recipe: recipe,
              ref: ref,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                elevation: 0,
                color: Palette.white,
                surfaceTintColor: Palette.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Info',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 10,
                          children: [
                            _buildInfoItem(
                                'Health Score', '${recipe.healthScore}'),
                            _buildInfoItem(
                                'Vegetarian', recipe.vegetarian ? 'Yes' : 'No'),
                            _buildInfoItem(
                                'Vegan', recipe.vegan ? 'Yes' : 'No'),
                            _buildInfoItem('Gluten Free',
                                recipe.glutenFree ? 'Yes' : 'No'),
                            _buildInfoItem(
                                'Dairy Free', recipe.dairyFree ? 'Yes' : 'No'),
                          ],
                        ),
                      ),
                      Wrap(
                        children: [
                          for (final taste in recipe.taste.toJson().entries)
                            _buildTasteIndicator(taste.key, taste.value),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                for (int index = 0; index < recipe.steps.length; index++)
                  ListTile(
                    title: Text(
                      'Step - ${(recipe.steps[index].number).toString()}',
                      style: TextStyle(
                        color: index.isOdd ? Palette.orange : Palette.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      (recipe.steps[index].step).toString(),
                      style: const TextStyle(
                        color: Palette.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildInfoItem('Source URL', recipe.sourceUrl),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Chip(
      label: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTasteIndicator(String label, double percentage) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  value: percentage / 100,
                  strokeWidth: 4,
                  backgroundColor: Palette.liteGrey,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Palette.green),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
