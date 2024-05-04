import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/palette.dart';
import '../../../models/recipe_details.dart';
import '../screens/recipe_details_screen.dart';
import 'bookmark_button.dart';
import 'ingredients_row.dart';

class RecipeListItem extends StatelessWidget {
  const RecipeListItem({
    super.key,
    required this.recipe,
    required this.ref,
  });

  final RecipeDetails recipe;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
              recipe: recipe,
            ),
          ));
        },
        child: Card(
          color: Palette.white,
          surfaceTintColor: Palette.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Hero(
                        tag: recipe.id,
                        child: Image.network(
                          recipe.imageUrl,
                          height: MediaQuery.of(context).size.width * 0.35,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Card(
                      color: Palette.white.withOpacity(0.2),
                      surfaceTintColor: Palette.white.withOpacity(0.2),
                      child: BookmarkButton(ref: ref, recipe: recipe),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: buildIngredientsRow(recipe.ingredients),
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
