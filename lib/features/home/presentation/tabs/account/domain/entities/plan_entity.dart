class PlanEntity {
  final String? id;
  final String title;
  final String description;
  final String? price;
  final DateTime? createdAt;

  const PlanEntity({
    this.id,
    required this.title,
    required this.description,
    this.price,
    this.createdAt,
  });
}
