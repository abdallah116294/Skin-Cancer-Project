class Disease {
  final String name;
  final String description;
  final String symptoms;

  Disease({required this.name, required this.description, required this.symptoms});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      name: json['name'],
      description: json['description'],
      symptoms: json['symptoms'],
    );
  }
}
