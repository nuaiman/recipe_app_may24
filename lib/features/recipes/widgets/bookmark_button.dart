import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/palette.dart';
import '../../../models/recipe_details.dart';
import '../notifiers/saver_notifier.dart';

class BookmarkButton extends StatelessWidget {
  const BookmarkButton({
    super.key,
    required this.ref,
    required this.recipe,
  });

  final WidgetRef ref;
  final RecipeDetails recipe;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ref.read(saverProvider.notifier).saveOrRemoveRecipe(recipe);
      },
      icon: ref.read(saverProvider.notifier).containsRecipe(recipe.id)
          ? const Icon(
              Icons.bookmark,
              color: Palette.orange,
            )
          : const Icon(
              Icons.bookmark_outline,
              color: Palette.white,
            ),
    );
  }
}
