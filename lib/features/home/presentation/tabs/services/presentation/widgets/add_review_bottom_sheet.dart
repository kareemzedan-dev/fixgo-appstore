import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_top_error_message.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/l10n/app_localizations.dart';

typedef ReviewSubmitCallback =
    Future<void> Function(double rating, String comment);

class AddReviewBottomSheet extends StatefulWidget {
  final ReviewSubmitCallback onSubmit;

  const AddReviewBottomSheet({super.key, required this.onSubmit});

  @override
  State<AddReviewBottomSheet> createState() => _AddReviewBottomSheetState();
}

class _AddReviewBottomSheetState extends State<AddReviewBottomSheet> {
  final commentController = TextEditingController();
  double selectedRating = 5;
  bool isSubmitting = false;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => isSubmitting = true);
    try {
      await widget.onSubmit(selectedRating, commentController.text.trim());
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() => isSubmitting = false);
      CustomTopErrorMessage.show(context, message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppSizes.p20,
            right: AppSizes.p20,
            top: AppSizes.p24,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.p24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context).addReview,
                  style: TextStyle(
                    fontSize: AppSizes.sp(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: AppSizes.h(24)),
              Text(
                AppLocalizations.of(context).ratingLabel,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: AppSizes.h(10)),
              Row(
                children: List.generate(
                  5,
                  (index) => IconButton(
                    onPressed: () {
                      setState(() => selectedRating = index + 1.0);
                    },
                    icon: Icon(
                      Icons.star,
                      color: index < selectedRating
                          ? Colors.amber
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.h(20)),
              TextField(
                controller: commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).reviewHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r16),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.h(24)),
              SizedBox(
                width: double.infinity,
                height: AppSizes.h(54),
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D3964),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r16),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context).sendReview,
                    style: TextStyle(
                      fontSize: AppSizes.sp(12),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isSubmitting)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
