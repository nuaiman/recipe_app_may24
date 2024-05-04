import 'package:flutter/material.dart';

import '../../../core/constants/palette.dart';
import '../../../models/recipe_details.dart';

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
            color: Palette.green,
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
            color: Palette.green,
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
