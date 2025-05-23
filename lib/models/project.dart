class Project {
  final String id;
  final String name;

  Project({
    required this.id,
    required this.name,
  });

  // Optional: For JSON serialization
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
