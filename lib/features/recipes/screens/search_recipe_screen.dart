import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app_may24/core/constants/svg_constants.dart';
import 'package:recipes_app_may24/core/notifiers/loader_notifier.dart';
import 'package:recipes_app_may24/features/recipes/notifiers/recipes_notifier.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_app_may24/features/recipes/notifiers/saver_notifier.dart';

import '../widgets/main_app_bar.dart';
import '../widgets/recipe_list_builder.dart';

class SearchRecipeScreen extends ConsumerStatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  ConsumerState<SearchRecipeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<SearchRecipeScreen> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void clearSearch(WidgetRef ref) {
    setState(() {
      searchController.clear();
    });
    ref.read(recipesProvider.notifier).clearState();
  }

  @override
  Widget build(BuildContext context) {
    final recipes = ref.watch(recipesProvider);
    final isLoading = ref.watch(loaderProvider);
    ref.watch(saverProvider);
    return Scaffold(
      appBar: searchRecipesAppBar(isLoading),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: searchRecipesField(),
          ),
          Expanded(
            child: RecipeListBuilder(recipes: recipes, ref: ref),
          ),
        ],
      ),
    );
  }

  TextField searchRecipesField() {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      controller: searchController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        filled: true,
        fillColor: const Color(0xFFF1F1F5),
        hintText: 'Write Recipe Name',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed:
              searchController.text.isEmpty ? () {} : () => clearSearch(ref),
          icon: searchController.text.isEmpty
              ? const Icon(Icons.search)
              : const Icon(Icons.close),
        ),
      ),
      onChanged: (value) {
        () => clearSearch(ref);
        ref.read(recipesProvider.notifier).searchRecipes(value);
      },
    );
  }

  MainAppBar searchRecipesAppBar(bool isLoading) {
    return MainAppBar(
      isLoading: isLoading,
      badgeCount: ref.read(recipesProvider).length,
      titleWidget: Row(
        children: [
          SvgPicture.asset(Svgs.logo),
          const SizedBox(width: 10),
          isLoading
              ? const Center(
                  child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Color(0xFFED6A32),
                  ),
                ))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
