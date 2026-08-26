import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/offers/presentation/manager/update_offer_cubit/update_offer_cubit.dart';
import 'service_details_area_chip.dart';

class ServiceDetailsAreaSection extends StatefulWidget {
  final dynamic offer;
  final bool isOwner;

  const ServiceDetailsAreaSection({
    Key? key,
    required this.offer,
    this.isOwner = false,
  }) : super(key: key);

  @override
  State<ServiceDetailsAreaSection> createState() =>
      _ServiceDetailsAreaSectionState();
}

class _ServiceDetailsAreaSectionState extends State<ServiceDetailsAreaSection> {
  late List<String> areas;
  @override
  void initState() {
    super.initState();

    /// 👇 لو عندك location واحدة
    /// حولها list
    if (widget.offer.location is String) {
      areas = [widget.offer.location];
    } else {
      areas = List<String>.from(widget.offer.location ?? []);
    }
  }

  /// =========================
  /// ➕ ADD AREA
  /// =========================
  void addArea() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).addWorkArea),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).enterArea,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context).cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                final newArea = controller.text.trim();
                if (newArea.isEmpty) return;

                areas.add(newArea);

                /// 🔥 update firestore
                await context.read<UpdateOfferCubit>().updateOffer(
                  offerId: widget.offer.id,
                  title: widget.offer.title,
                  description: widget.offer.description,
                  category: widget.offer.category,
                  serviceCategory: widget.offer.serviceCategory,
                  yearsOfExperience: widget.offer.yearsOfExperience,
                  imageUrl: widget.offer.imageUrl,
                  images: widget.offer.images ?? [],

                  /// 👇 هنا الفرق
                  location: areas.join(","),
                );

                setState(() {});
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context).add,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        Text(
          AppLocalizations.of(context).serviceAreas,
          style: TextStyle(
            fontSize: AppSizes.sp(14),
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: AppSizes.h(14)),

        /// =========================
        /// 🔥 Chips + Add Button
        /// =========================
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            /// 👇 كل المناطق
            ...areas.map((area) => ServiceDetailsAreaChip(title: area)),

            /// 👇 زرار الإضافة
            if (widget.isOwner)
              GestureDetector(
                onTap: addArea,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isDark ? Color(0Xff1E1E1E) : Colors.grey.shade200,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        AppLocalizations.of(context).add,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
