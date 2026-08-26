import '../../domain/entities/plan_entity.dart';

class Plan {
  String? id;
  String title;
  String description;
  String? price;
  DateTime? createdAt;

  Plan({
    this.id,
    required this.title,
    required this.description,
    this.price,
    this.createdAt,
  });

  Plan copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    DateTime? createdAt,
  }) {
    return Plan(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  static Plan fromMap(Map<String, dynamic> map, String docId) {
    return Plan(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }

  PlanEntity toEntity() {
    return PlanEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      createdAt: createdAt,
    );
  }
}
