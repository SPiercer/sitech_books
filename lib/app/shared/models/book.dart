class Book {
  final int id;
  final String name;
  final String coverImg;
  final String author;
  final String description;
  final DateTime createdAt;

  Book._({
    required this.id,
    required this.name,
    required this.coverImg,
    required this.author,
    required this.description,
    required this.createdAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book._(
      id: int.tryParse(json['id'].toString()) ?? json['id'],
      name: json['name'],
      coverImg: json['cover'],
      author: json['author'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cover': coverImg,
      'author': author,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Book {id: $id, name: $name}";
  }
}
