/// data/models/add_service_model.dart

library;

import '../../domain/entities/add_service_entity.dart';

class AddServiceModel extends AddServiceEntity {
  const AddServiceModel({
    required super.title,
    required super.description,

    required super.city,
    required super.neighborhood,

    required super.category,
    required super.serviceCategory,

    /// الجديد
    required super.yearsOfExperience,

    required super.latitude,
    required super.longitude,

    required super.images,
  });

  factory AddServiceModel.fromEntity(
    AddServiceEntity entity,
  ) {
    return AddServiceModel(
      title: entity.title,
      description: entity.description,

      city: entity.city,
      neighborhood: entity.neighborhood,

      category: entity.category,
      serviceCategory:
          entity.serviceCategory,

      /// الجديد
      yearsOfExperience:
          entity.yearsOfExperience,

      latitude: entity.latitude,
      longitude: entity.longitude,

      images: entity.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,

      "city": city,
      "neighborhood":
          neighborhood,

      "category": category,
      "serviceCategory":
          serviceCategory,

      /// الجديد
      "yearsOfExperience":
          yearsOfExperience,

      "latitude": latitude,
      "longitude": longitude,

      "images": images,
    };
  }
}