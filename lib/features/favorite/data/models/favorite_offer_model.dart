import '../../domain/entities/favorite_offer_entity.dart';

class FavoriteOfferModel
    extends FavoriteOfferEntity {
  const FavoriteOfferModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    super.userName,
    super.profession,
    required super.averageRating,
    required super.location,
    required super.userId,
        required super.yearsOfExperience,

  });

  factory FavoriteOfferModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return FavoriteOfferModel(
      id: id,
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      userName: map['userName'],
      profession: map['profession'],
      averageRating:
          (map['averageRating'] ?? 0)
              .toDouble(),
      location: map['location'] ?? '',
      userId: map['userId'] ?? '',
      yearsOfExperience: map['yearsOfExperience'] ?? 0,
    );
  }
}