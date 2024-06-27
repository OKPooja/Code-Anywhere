class ProblemDesc {
  final String name;
  final String description;
  final String inputFormat;
  final String outputFormat;
  final String rating;

  ProblemDesc({
    required this.name,
    required this.description,
    required this.inputFormat,
    required this.outputFormat,
    required this.rating,
  });

  factory ProblemDesc.fromJson(Map<String, dynamic> json) {
    return ProblemDesc(
      name: json['Question Name'],
      description: json['Question Description'],
      inputFormat: json['Input Format'],
      outputFormat: json['Output Format'],
      rating: json['Rating'],
    );
  }
}
