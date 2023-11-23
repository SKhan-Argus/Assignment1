class TodoAdd {
  final String title;
  final String description;

  TodoAdd({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description};
  }
}
