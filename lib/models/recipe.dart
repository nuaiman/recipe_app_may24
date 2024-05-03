import 'dart:convert';

class Recipe {
  int id;
  String title;
  String imageUrl;
  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  Recipe copyWith({
    int? id,
    String? title,
    String? imageUrl,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'imageUrl': imageUrl});

    return result;
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      imageUrl: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source));

  @override
  String toString() => 'Recipe(id: $id, title: $title, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Recipe &&
        other.id == id &&
        other.title == title &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ imageUrl.hashCode;
}

// class Recipe {
//   final String id;
//   final String name;
//   final int duration;
//   final List<Ingredients> ingredients;
//   int serving;
// }

// class Ingredients {
//   final String name;
// }

// class Steps {
//   final int count;
//   final String imageUrl;
//   final String description;
// }
