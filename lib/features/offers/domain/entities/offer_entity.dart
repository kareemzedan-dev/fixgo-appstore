/// ===============================
/// domain/entities/offer_entity.dart
/// النسخة الصحيحة الكاملة
/// ===============================

class OfferEntity {
  final String id;
  final String userId;

  final String title;
  final String location;
  final String neighborhood;
  final String category;

  final String serviceCategory;
  final String description;

  /// الأفضل الحقيقي
  final int yearsOfExperience;
final bool isVerified;
  final String imageUrl;
  final List<String> images;

  final String phone;

  final String? userName;
  final String? userImageUrl;
  final String? profession;

  final double averageRating;
  final int ratingsCount;

  final double latitude;
  final double longitude;

  /// إعلان عام
  final bool isSponsored;

  /// Sponsored Package
  final bool sp;

  /// View Sponsored
  final bool isViewSponsored;

  /// عدد المشاهدات المتبقية
  final int remainingViews;

  /// إجمالي المشاهدات
  final int totalViews;

  /// آخر مشاهدة
  final DateTime? lastViewAt;

  /// انتهاء صلاحية المشاهدات
  final DateTime? viewsExpireAt;

  /// الباقة المستخدمة
  final String? boostPackageId;

  /// تفاصيل المهنة
  final String? professionDetails;

  /// ترتيب مخصص
  final int? order;

  final double distance;

  const OfferEntity({
    required this.id,
    required this.userId,

    required this.title,
    required this.location,
    required this.neighborhood,
    required this.category,

    required this.serviceCategory,
    required this.description,

    required this.yearsOfExperience,

    required this.imageUrl,
    this.images = const [],

    required this.phone,

    required this.isVerified,

    this.userName,
    this.userImageUrl,
    this.profession,

    required this.averageRating,
    required this.ratingsCount,

    required this.latitude,
    required this.longitude,

    required this.isSponsored,

    /// الجديد
    this.sp = false,
    this.isViewSponsored = false,
    this.remainingViews = 0,
    this.totalViews = 0,
    this.lastViewAt,
    this.viewsExpireAt,
    this.boostPackageId,
    this.professionDetails,
    this.order,

    this.distance = 0,
  });

  OfferEntity copyWith({
    String? id,
    String? userId,
    String? title,
    String? location,
    String? neighborhood,
    String? category,
    String? serviceCategory,
    String? description,
    int? yearsOfExperience,
    bool? isVerified,
    String? imageUrl,
    List<String>? images,
    String? phone,
    String? userName,
    String? userImageUrl,
    String? profession,
    double? averageRating,
    int? ratingsCount,
    double? latitude,
    double? longitude,
    bool? isSponsored,
    bool? sp,
    bool? isViewSponsored,
    int? remainingViews,
    int? totalViews,
    DateTime? lastViewAt,
    DateTime? viewsExpireAt,
    String? boostPackageId,
    String? professionDetails,
    int? order,
    double? distance,
  }) {
    return OfferEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      location: location ?? this.location,
      neighborhood: neighborhood ?? this.neighborhood,
      category: category ?? this.category,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      description: description ?? this.description,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      isVerified: isVerified ?? this.isVerified,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      phone: phone ?? this.phone,
      userName: userName ?? this.userName,
      userImageUrl: userImageUrl ?? this.userImageUrl,
      profession: profession ?? this.profession,
      averageRating: averageRating ?? this.averageRating,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isSponsored: isSponsored ?? this.isSponsored,
      sp: sp ?? this.sp,
      isViewSponsored: isViewSponsored ?? this.isViewSponsored,
      remainingViews: remainingViews ?? this.remainingViews,
      totalViews: totalViews ?? this.totalViews,
      lastViewAt: lastViewAt ?? this.lastViewAt,
      viewsExpireAt: viewsExpireAt ?? this.viewsExpireAt,
      boostPackageId: boostPackageId ?? this.boostPackageId,
      professionDetails: professionDetails ?? this.professionDetails,
      order: order ?? this.order,
      distance: distance ?? this.distance,
    );
  }
}