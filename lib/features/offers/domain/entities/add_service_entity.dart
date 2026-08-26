/// domain/entities/add_service_entity.dart

library;

class AddServiceEntity {
  final String title;
  final String description;

  final String city;
  final String neighborhood;

  final String category;
  final String serviceCategory;

  /// الجديد
  /// عدد سنوات الخبرة
  final int yearsOfExperience;

  final double latitude;
  final double longitude;

  final List<dynamic> images;

  const AddServiceEntity({
    required this.title,
    required this.description,

    required this.city,
    required this.neighborhood,

    required this.category,
    required this.serviceCategory,

    /// الجديد
    required this.yearsOfExperience,

    required this.latitude,
    required this.longitude,

    required this.images,
  });
}