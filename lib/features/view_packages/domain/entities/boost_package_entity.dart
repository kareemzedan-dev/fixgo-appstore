class BoostPackageEntity {
  final String id;
  final String title;
  final int views;
  final String price;
  final String duration;
  final String description;
  final String bankAccount;
  final bool isActive;

  const BoostPackageEntity({
    required this.id,
    required this.title,
    required this.views,
    required this.price,
    required this.duration,
    required this.description,
    required this.bankAccount,
    required this.isActive,
  });
}