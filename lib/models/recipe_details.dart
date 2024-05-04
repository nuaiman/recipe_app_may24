class RecipeDetails {
  final int id;
  final String name;
  final int duration;
  final String imageUrl;
  final int healthScore;
  final int serving;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final String sourceUrl;
  final Taste taste;
  final List<DishType> dishTypes;
  final List<Step> steps;
  final List<Ingredient> ingredients;

  RecipeDetails({
    required this.id,
    required this.name,
    required this.duration,
    required this.imageUrl,
    required this.healthScore,
    required this.serving,
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.sourceUrl,
    required this.taste,
    required this.dishTypes,
    required this.steps,
    required this.ingredients,
  });

  factory RecipeDetails.fromJson(Map<String, dynamic> json) {
    final List<String> allIngredients = [];
    final List<String> ingredientsFromSteps =
        (json['analyzedInstructions'] as List<dynamic>)
            .expand((section) => section['steps'])
            .expand((step) => step['ingredients'])
            .map<String>((ingredient) => ingredient['name'])
            .toList();
    for (final ingredient in ingredientsFromSteps) {
      if (!allIngredients.contains(ingredient)) {
        allIngredients.add(ingredient);
      }
    }

    final List<Ingredient> ingredients =
        (json['extendedIngredients'] as List<dynamic>)
            .map<Ingredient>((ingredient) => Ingredient.fromJson(ingredient))
            .toList();

    return RecipeDetails(
      id: json['id'],
      name: json['title'],
      duration: json['readyInMinutes'],
      imageUrl: json['image'],
      healthScore: json['healthScore'],
      serving: json['servings'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      glutenFree: json['glutenFree'],
      dairyFree: json['dairyFree'],
      sourceUrl: json['sourceUrl'],
      taste: Taste.fromJson(json['taste']),
      dishTypes: (json['dishTypes'] as List<dynamic>)
          .map((type) => DishType.fromJson(type))
          .toList(),
      steps: (json['analyzedInstructions'] as List<dynamic>)
          .expand((section) => section['steps'])
          .map((step) => Step.fromJson(step))
          .toList(),
      ingredients: ingredients,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'readyInMinutes': duration,
      'image': imageUrl,
      'healthScore': healthScore,
      'servings': serving,
      'vegetarian': vegetarian,
      'vegan': vegan,
      'glutenFree': glutenFree,
      'dairyFree': dairyFree,
      'sourceUrl': sourceUrl,
      'taste': taste.toJson(),
      'dishTypes': dishTypes.map((type) => type.toJson()).toList(),
      'analyzedInstructions': [
        {'steps': steps.map((step) => step.toJson()).toList()}
      ],
      'extendedIngredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
    };
  }

  RecipeDetails copyWith({
    int? id,
    String? name,
    int? duration,
    String? imageUrl,
    int? healthScore,
    int? serving,
    bool? vegetarian,
    bool? vegan,
    bool? glutenFree,
    bool? dairyFree,
    String? sourceUrl,
    Taste? taste,
    List<DishType>? dishTypes,
    List<Step>? steps,
    List<Ingredient>? ingredients,
  }) {
    return RecipeDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      imageUrl: imageUrl ?? this.imageUrl,
      healthScore: healthScore ?? this.healthScore,
      serving: serving ?? this.serving,
      vegetarian: vegetarian ?? this.vegetarian,
      vegan: vegan ?? this.vegan,
      glutenFree: glutenFree ?? this.glutenFree,
      dairyFree: dairyFree ?? this.dairyFree,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      taste: taste ?? this.taste,
      dishTypes: dishTypes ?? this.dishTypes,
      steps: steps ?? this.steps,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  @override
  String toString() {
    return 'RecipeDetails(id: $id, name: $name, duration: $duration, imageUrl: $imageUrl, healthScore: $healthScore, serving: $serving, vegetarian: $vegetarian, vegan: $vegan, glutenFree: $glutenFree, dairyFree: $dairyFree, sourceUrl: $sourceUrl, taste: $taste, dishTypes: $dishTypes, steps: $steps, ingredients: $ingredients)';
  }
}

class Taste {
  final double sweetness;
  final double saltiness;
  final double sourness;
  final double bitterness;
  final double savoriness;
  final double fattiness;
  final double spiciness;

  Taste({
    required this.sweetness,
    required this.saltiness,
    required this.sourness,
    required this.bitterness,
    required this.savoriness,
    required this.fattiness,
    required this.spiciness,
  });

  factory Taste.fromJson(Map<String, dynamic> json) {
    return Taste(
      sweetness: json['sweetness'],
      saltiness: json['saltiness'],
      sourness: json['sourness'],
      bitterness: json['bitterness'],
      savoriness: json['savoriness'],
      fattiness: json['fattiness'],
      spiciness: json['spiciness'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sweetness': sweetness,
      'saltiness': saltiness,
      'sourness': sourness,
      'bitterness': bitterness,
      'savoriness': savoriness,
      'fattiness': fattiness,
      'spiciness': spiciness,
    };
  }
}

class DishType {
  final String dishType;

  DishType({required this.dishType});

  factory DishType.fromJson(String json) {
    return DishType(dishType: json);
  }

  String toJson() => dishType;
}

class Step {
  final int number;
  final String step;

  Step({required this.number, required this.step});

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      number: json['number'],
      step: json['step'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'step': step,
    };
  }
}

class Ingredient {
  final String name;
  final double amount;
  final String unit;

  Ingredient({required this.name, required this.amount, required this.unit});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      amount: json['amount'] is int
          ? (json['amount'] as int).toDouble()
          : json['amount'] as double,
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'unit': unit,
    };
  }
}
