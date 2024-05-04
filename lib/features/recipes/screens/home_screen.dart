import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app_may24/core/constants/svg_constants.dart';
import 'package:recipes_app_may24/core/notifiers/loader_notifier.dart';
import 'package:recipes_app_may24/features/recipes/controllers/recipes_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        // leading: isLoading
        //     ? Center(
        //         child: SizedBox(
        //         height: 20,
        //         width: 20,
        //         child: CircularProgressIndicator(
        //           color: Color(0xFFED6A32),
        //         ),
        //       ))
        //     : const SizedBox.shrink(),
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
            child: TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              controller: searchController,
              decoration: InputDecoration(
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
              onChanged: (value) {
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
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                recipe.imageUrl,
                                height: MediaQuery.of(context).size.width * 0.4,
                                fit: BoxFit.cover,
                              ),
                            ),
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
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget buildIngredientsRow(List<String> ingredients) {
    List<Widget> children = [];

    if (ingredients.length <= 3) {
      for (int i = 0; i < ingredients.length; i++) {
        children.add(Text(
          ingredients[i],
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
          ingredients[i],
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