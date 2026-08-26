import 'package:flutter/material.dart';
import 'package:fixgo/core/components/custom_text_field.dart';
import 'package:fixgo/core/constants/service_categories.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/assets_manager.dart';
import 'package:fixgo/core/utils/colors_manager.dart';
import 'package:fixgo/features/auth/presentation/widgets/phone_text_field.dart';
import 'package:fixgo/features/auth/presentation/widgets/worker_extra_fields.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class RegisterFormSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final bool isWorker;
  final String? selectedService;
  final String? selectedCategory;
  final String? selectedYears;
  final List<String> yearsList;
  final ValueChanged<String?> onServiceChanged;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onYearsChanged;
  final ValueChanged<bool> onCompanyChanged;

  bool isCompany;

  RegisterFormSection({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.passwordController,
    required this.isWorker,
    required this.selectedService,
    required this.selectedCategory,
    required this.selectedYears,
    required this.yearsList,
    required this.onServiceChanged,
    required this.onCategoryChanged,
    required this.onYearsChanged,
    required this.onCompanyChanged,
    required this.isCompany,
  });

  @override
  State<RegisterFormSection> createState() => _RegisterFormSectionState();
}

class _RegisterFormSectionState extends State<RegisterFormSection> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isWorker) ...[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorsManager.grey.withValues(alpha: 0.3),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF1E1E1E)
                    : const Color(0xFFE8E8E8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.accountType),
                TextButton(
                  onPressed: () {
                    widget.onCompanyChanged(false);
                  },
                  child: Text(l10n.freelancer),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      widget.isCompany
                          ? ColorsManager.white
                          : ColorsManager.secondaryColor,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      widget.isCompany
                          ? ColorsManager.black
                          : ColorsManager.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.onCompanyChanged(true);
                    });
                  },
                  child: Text(l10n.company),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      widget.isCompany
                          ? ColorsManager.secondaryColor
                          : ColorsManager.white,
                    ),

                    foregroundColor: WidgetStatePropertyAll(
                      widget.isCompany
                          ? ColorsManager.white
                          : ColorsManager.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        SizedBox(
          width: 335,
          child: Text(
            l10n.username,
            style: TextStyle(
              fontSize: AppSizes.sp(16),
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: l10n.enterYourName,
          controller: widget.nameController,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 335,
          child: Text(
            l10n.phoneNumber,
            style: TextStyle(
              fontSize: AppSizes.sp(16),
              fontWeight: FontWeight.w400,
              height: 1.60,
            ),
          ),
        ),
        const SizedBox(height: 8),
        PhoneTextField(controller: widget.phoneController),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: l10n.password,
          controller: widget.passwordController,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF0F0F1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                AssetsManager.alert,
                width: AppSizes.w(16),
                height: AppSizes.w(16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.otpLoginNotice,
                  style: TextStyle(
                    fontSize: AppSizes.sp(10),
                    fontWeight: FontWeight.w400,
                    height: 1.60,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.isWorker) ...[
          const SizedBox(height: 20),
          WorkerExtraFields(
            selectedService: widget.selectedService,
            selectedCategory: widget.selectedCategory,
            selectedYears: widget.selectedYears,
            services: widget.selectedCategory == null
                ? []
                : ServiceCategories.getServicesByCategory(
                    widget.selectedCategory!,
                  ),
            categories: ServiceCategories.mainCategories,
            yearsList: widget.yearsList,
            onServiceChanged: widget.onServiceChanged,
            onCategoryChanged: widget.onCategoryChanged,
            onYearsChanged: widget.onYearsChanged,
          ),
        ],
      ],
    );
  }
}
