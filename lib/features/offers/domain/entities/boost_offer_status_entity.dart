class BoostOfferStatusEntity {
  final bool isViewSponsored;
  final int remainingViews;
  final int totalViews;
  final DateTime? viewsExpireAt;

  const BoostOfferStatusEntity({
    required this.isViewSponsored,
    required this.remainingViews,
    required this.totalViews,
    required this.viewsExpireAt,
  });
}
