import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app_may24/core/constants/svg_constants.dart';
import 'package:recipes_app_may24/core/notifiers/loader_notifier.dart';
import 'package:recipes_app_may24/features/recipes/notifiers/recipes_notifier.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipes_app_may24/features/recipes/notifiers/saver_notifier.dart';
import 'package:recipes_app_may24/features/recipes/screens/recipe_details_screen.dart';
import 'package:recipes_app_may24/models/recipe_details.dart';

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
      appBar: AppBar(
        centerTitle: false,
        title: Row(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Badge(
              backgroundColor: const Color(0xFFED6A32),
              label: Text(
                ref.watch(recipesProvider).length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Icon(
                Icons.fastfood_outlined,
                color: Color(0xFF2EACAA),
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              controller: searchController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                filled: true,
                fillColor: const Color(0xFFF1F1F5),
                hintText: 'Write Recipe Name',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: searchController.text.isEmpty
                      ? () {}
                      : () => clearSearch(ref),
                  icon: searchController.text.isEmpty
                      ? const Icon(Icons.search)
                      : const Icon(Icons.close),
                ),
              ),
              // onSubmitted: (value) {
              //   ref.read(recipesProvider.notifier).searchRecipes(value);
              // },
              onChanged: (value) {
                () => clearSearch(ref);
                ref.read(recipesProvider.notifier).searchRecipes(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
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
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
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
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Card(
                                    color: Colors.white.withOpacity(0.2),
                                    surfaceTintColor:
                                        Colors.white.withOpacity(0.2),
                                    child: IconButton(
                                      onPressed: () {
                                        ref
                                            .read(saverProvider.notifier)
                                            .saveOrRemoveRecipe(recipe);
                                      },
                                      icon: ref
                                              .read(saverProvider.notifier)
                                              .containsRecipe(recipe.id)
                                          ? Icon(
                                              Icons.bookmark,
                                              color: Colors.orange,
                                            )
                                          : Icon(
                                              Icons.bookmark_outline,
                                              color: Colors.white,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: buildIngredientsRow(recipe.ingredients),
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget buildIngredientsRow(List<Ingredient> ingredients) {
    List<Widget> children = [];

    if (ingredients.length <= 3) {
      for (int i = 0; i < ingredients.length; i++) {
        children.add(Text(
          ingredients[i].name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ));
        if (i < ingredients.length - 1) {
          children.add(const Text(
            '  |  ',
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.w600,
            ),
          ));
        }
      }
    } else {
      for (int i = 0; i < 3; i++) {
        children.add(Text(
          ingredients[i].name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ));
        if (i < 2) {
          children.add(const Text(
            '  |  ',
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.w600,
            ),
          ));
        }
      }
      children.add(const Text(
        '  etc.',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ));
    }

    return Wrap(
      alignment: WrapAlignment.start,
      children: children,
    );
  }
}
