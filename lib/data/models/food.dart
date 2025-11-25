class Food {
  final String id;
  final String name;
  final double calories; // total kalori
  final double weight;   // gram
  final DateTime date;   // waktu input

  Food({
    required this.id,
    required this.name,
    required this.calories,
    required this.weight,
    required this.date,
  });

  // Convert ke Map (untuk SharedPreferences)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'weight': weight,
      'date': date.toIso8601String(),
    };
  }

  // Convert Map ke object Food
  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'],
      name: map['name'],
      calories: map['calories'],
      weight: map['weight'],
      date: DateTime.parse(map['date']),
    );
  }
}
