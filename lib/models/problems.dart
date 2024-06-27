class Problem {
  final String id;
  final String name;

  Problem({required this.id, required this.name});

  factory Problem.fromJson(List<dynamic> json) {
    return Problem(
      id: json[0] as String,
      name: json[1] as String,
    );
  }
}