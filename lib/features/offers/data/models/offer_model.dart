/// ===============================
/// data/models/offer_model.dart
/// النسخة الكاملة الصحيحة النهائية
/// ===============================

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/offer_entity.dart';

class OfferModel extends OfferEntity {
  final Timestamp timestamp;

  const OfferModel({
    required super.id,
    required super.userId,

    required super.title,
    required super.location,
    required super.neighborhood,
    required super.category,

    required super.serviceCategory,
    required super.description,

    required super.yearsOfExperience,

    required super.imageUrl,
    required super.images,

    required super.phone,

    super.userName,
    super.userImageUrl,
    super.profession,

    required super.averageRating,
    required super.ratingsCount,

    required super.latitude,
    required super.longitude,

    required super.isSponsored,

    required super.sp,
    required super.isViewSponsored,
    required super.remainingViews,
    required super.totalViews,
    super.lastViewAt,
    super.viewsExpireAt,
    super.boostPackageId,
    super.professionDetails,
    super.order,
    required super.distance,

    required this.timestamp, required super.isVerified,

  });

  factory OfferModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return OfferModel(
      id: doc.id,
      userId: data['userId'] ?? '',

      title: data['title'] ?? '',
      location: data['location'] ?? '',
      neighborhood:
          data['neighborhood'] ?? '',
      category: data['category'] ?? '',

      serviceCategory:
          data['serviceCategory'] ?? '',

      description:
          data['description'] ?? '',

      yearsOfExperience:
          data['yearsOfExperience'] ?? 0,

      imageUrl:
          data['imageUrl'] ?? '',

      images: List<String>.from(
        data['images'] ?? [],
      ),

      phone:
          data['phone'] ?? '',

      userName:
          data['userName'],

      userImageUrl:
          data['userImageUrl'],

      profession:
          data['profession'],

      averageRating:
          (data['averageRating'] ?? 0)
              .toDouble(),

      ratingsCount:
          data['ratingsCount'] ?? 0,

      latitude:
          (data['latitude'] ?? 0)
              .toDouble(),

      longitude:
          (data['longitude'] ?? 0)
              .toDouble(),
              isVerified:  data['isVerified'] ?? false,
 
      isSponsored:
          (data['SP'] ?? false) ||
              (data['isViewSponsored'] ??
                  false),

      sp:
          data['SP'] ?? false,

      isViewSponsored:
          data['isViewSponsored'] ??
              false,

      remainingViews:
          data['remainingViews'] ?? 0,

      totalViews:
          data['totalViews'] ?? 0,

      lastViewAt:
          (data['lastViewAt']
                  as Timestamp?)
              ?.toDate(),

      viewsExpireAt:
          (data['viewsExpireAt']
                  as Timestamp?)
              ?.toDate(),

      boostPackageId:
          data['boostPackageId'],

      professionDetails:
          data['professionDetalies'],

      order:
          data['order'],

      distance:
          (data['distance'] ?? 0)
              .toDouble(),

      timestamp:
          data['timestamp'] ??
              Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,

      'title': title,
      'location': location,
      'neighborhood':
          neighborhood,
      'category': category,

      'serviceCategory':
          serviceCategory,

      'description':
          description,

      'yearsOfExperience':
          yearsOfExperience,

      'imageUrl':
          imageUrl,
          'isVerified': isVerified,

      'images':
          images,

      'phone':
          phone,

      'userName':
          userName,

      'userImageUrl':
          userImageUrl,

      'profession':
          profession,

      'averageRating':
          averageRating,

      'ratingsCount':
          ratingsCount,

      'latitude':
          latitude,

      'longitude':
          longitude,

      'SP':
          sp,

      'isViewSponsored':
          isViewSponsored,

      'remainingViews':
          remainingViews,

      'totalViews':
          totalViews,

      'lastViewAt':
          lastViewAt != null
              ? Timestamp.fromDate(
                  lastViewAt!,
                )
              : null,

      'viewsExpireAt':
          viewsExpireAt != null
              ? Timestamp.fromDate(
                  viewsExpireAt!,
                )
              : null,

      'boostPackageId':
          boostPackageId,

      'professionDetalies':
          professionDetails,

      'order':
          order,

      'distance':
          distance,

      'timestamp':
          timestamp,
    };
  }

  OfferModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? location,
    String? neighborhood,
    String? category,
    String? serviceCategory,
    String? description,
    int? yearsOfExperience,
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
    Timestamp? timestamp,
      bool ?isVerified,
  }) {
    return OfferModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,

      title: title ?? this.title,
      location:
          location ?? this.location,
      neighborhood:
          neighborhood ??
              this.neighborhood,
      category:
          category ?? this.category,

      serviceCategory:
          serviceCategory ??
              this.serviceCategory,

      description:
          description ??
              this.description,

      yearsOfExperience:
          yearsOfExperience ??
              this.yearsOfExperience,

      imageUrl:
          imageUrl ?? this.imageUrl,

      images:
          images ?? this.images,

      phone:
          phone ?? this.phone,

      userName:
          userName ?? this.userName,

      userImageUrl:
          userImageUrl ??
              this.userImageUrl,

      isVerified:
          isVerified ?? this.isVerified,

      profession:
          profession ??
              this.profession,

      averageRating:
          averageRating ??
              this.averageRating,

      ratingsCount:
          ratingsCount ??
              this.ratingsCount,

      latitude:
          latitude ?? this.latitude,

      longitude:
          longitude ??
              this.longitude,

      isSponsored:
          isSponsored ??
              this.isSponsored,

      sp: sp ?? this.sp,

      isViewSponsored:
          isViewSponsored ??
              this.isViewSponsored,

      remainingViews:
          remainingViews ??
              this.remainingViews,

      totalViews:
          totalViews ??
              this.totalViews,

      lastViewAt:
          lastViewAt ??
              this.lastViewAt,

      viewsExpireAt:
          viewsExpireAt ??
              this.viewsExpireAt,

      boostPackageId:
          boostPackageId ??
              this.boostPackageId,

      professionDetails:
          professionDetails ??
              this.professionDetails,

      order:
          order ?? this.order,

      distance:
          distance ?? this.distance,

      timestamp:
          timestamp ??
              this.timestamp,
    );
  }
}