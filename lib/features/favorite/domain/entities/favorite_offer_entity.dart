class FavoriteOfferEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String? userName;
  final String? profession;
  final double averageRating;
  final String location;
  final String userId;
  final int yearsOfExperience;

  const FavoriteOfferEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.userName,
    this.profession,
    required this.averageRating,
    required this.location,
    required this.userId,
        required this.yearsOfExperience,

  });
}