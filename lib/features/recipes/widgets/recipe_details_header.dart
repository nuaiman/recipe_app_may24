import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/palette.dart';
import '../../../models/recipe_details.dart';
import '../notifiers/serving_calculation_notifier.dart';
import 'bookmark_button.dart';

class RecipeDetailsHeader extends StatelessWidget {
  const RecipeDetailsHeader({
    super.key,
    required this.recipe,
    required this.ref,
  });
  final WidgetRef ref;
  final RecipeDetails recipe;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Hero(
              tag: recipe.id,
              child: Image.network(recipe.imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 4, left: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: Palette.white.withOpacity(0.2),
                  surfaceTintColor: Palette.white.withOpacity(0.2),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Palette.white,
                    ),
                  ),
                ),
                Card(
                  color: Palette.white.withOpacity(0.2),
                  surfaceTintColor: Palette.white.withOpacity(0.2),
                  child: BookmarkButton(ref: ref, recipe: recipe),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 220),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                color: Palette.white,
                surfaceTintColor: Palette.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              recipe.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${recipe.duration} min',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Ingredients',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Serving',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(servingCalculationProvider.notifier)
                                      .addServingCount(1);
                                },
                                child: const CircleAvatar(
                                  radius: 16,
                                  child: Icon(Icons.add),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '${ref.read(servingCalculationProvider)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(servingCalculationProvider.notifier)
                                      .removeServingCount(1);
                                },
                                child: const CircleAvatar(
                                  radius: 16,
                                  child: Icon(Icons.remove),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          for (int index = 0;
                              index < recipe.ingredients.length;
                              index++)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  ' | ',
                                  style: TextStyle(
                                      color: Palette.green, fontSize: 20),
                                ),
                                Expanded(
                                  child: Text(
                                    '${recipe.ingredients[index].name} - ${ref.read(servingCalculationProvider.notifier).getUpdatedIngredientAmount(recipe.ingredients[index].amount).toStringAsFixed(2)} ${recipe.ingredients[index].unit}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
