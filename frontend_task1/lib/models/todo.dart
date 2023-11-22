class Todo {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool completed;

  Todo(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'completed': completed,
    };
  }

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      completed: completed ?? this.completed,
    );
  }
}
