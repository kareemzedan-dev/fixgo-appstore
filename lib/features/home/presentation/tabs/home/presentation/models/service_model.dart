import 'package:flutter/widgets.dart';

class ServiceModel {
  final String title;
  final String image;
  final String? categoryId;
  final VoidCallback? onTap;

  ServiceModel({
    required this.title,
    required this.image,
    this.categoryId,
    this.onTap,
  });
}
