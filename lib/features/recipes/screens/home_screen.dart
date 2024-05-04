import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app_may24/features/recipes/screens/saved_recipe_screen.dart';
import 'package:recipes_app_may24/features/recipes/screens/search_recipe_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Widget> screens = [
    const SearchRecipeScreen(),
    const SavedRecipesScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(int i) {
    setState(() {
      currentIndex = i;
    });
  }

  @override
  void didChangeDependencies() {
    // ref.read(saverProvider.notifier).getAllRecipes();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: CupertinoTabBar(
          currentIndex: currentIndex,
          onTap: (value) {
            changeIndex(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: Card(
                elevation: currentIndex == 0 ? 5 : 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: currentIndex == 0 ? Colors.orange : Colors.white,
                surfaceTintColor:
                    currentIndex == 0 ? Colors.orange : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.home,
                    color: currentIndex == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Card(
                elevation: currentIndex == 1 ? 5 : 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: currentIndex == 1 ? Colors.orange : Colors.white,
                surfaceTintColor:
                    currentIndex == 1 ? Colors.orange : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.book,
                    color: currentIndex == 1 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
