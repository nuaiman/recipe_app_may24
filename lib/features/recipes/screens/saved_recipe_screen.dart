import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app_may24/features/recipes/notifiers/saver_notifier.dart';

import '../../../core/constants/palette.dart';
import '../../../core/notifiers/loader_notifier.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/recipe_list_builder.dart';

class SavedRecipesScreen extends ConsumerWidget {
  const SavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(saverProvider);
    final isLoading = ref.watch(loaderProvider);
    ref.watch(saverProvider);
    return Scaffold(
      appBar: savedRecipesAppbar(isLoading, ref),
      body: RecipeListBuilder(recipes: recipes, ref: ref),
    );
  }

  MainAppBar savedRecipesAppbar(bool isLoading, WidgetRef ref) {
    return MainAppBar(
      isLoading: isLoading,
      badgeCount: ref.read(saverProvider).length,
      titleWidget: const Row(
        children: [
          Text(
            'Favor',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Palette.green),
          ),
          Text(
            'ites',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Palette.orange),
          ),
        ],
      ),
    );
  }
}
