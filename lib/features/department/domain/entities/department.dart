class Department {
  final int? id;
  final String name;
  final String? description;

  const Department({
    this.id,
    required this.name,
    this.description,
  });

  @override
  String toString() =>
      'Department(id: $id, name: $name, description: $description)';
}
