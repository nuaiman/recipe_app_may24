import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app_may24/features/recipes/controllers/recipes_controller.dart';

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

  void clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipes = ref.watch(recipesProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Write Recipe Name',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed:
                      searchController.text.isEmpty ? () {} : clearSearch,
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
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              recipe.imageUrl,
                              height: MediaQuery.of(context).size.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              recipe.name,
                              maxLines: 1,
                            ),
                            subtitle: recipe.ingredients.isEmpty
                                ? null
                                : Text(
                                    _buildIngredientsSubtitle(
                                        recipe.ingredients),
                                    maxLines: 1,
                                  ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.schedule),
                                const SizedBox(width: 2),
                                Text(recipe.duration.toString())
                              ],
                            ),
                          ),
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

  String _buildIngredientsSubtitle(List<String> ingredients) {
    if (ingredients.isEmpty) {
      return '';
    } else {
      String subtitle = ingredients.take(3).join(
            ' | ',
          );
      if (ingredients.length > 3) {
        subtitle += '  etc';
      }
      return subtitle;
    }
  }
}
