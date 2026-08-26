import 'package:flutter/material.dart';
import 'package:fixgo/core/constants/service_categories.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/filter_form.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/filter_header.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String? selectedCategory;
  String? selectedService;
  final List<String> categories = ServiceCategories.mainCategories;
  List<String> services = [];
  RangeValues ratingRange = const RangeValues(0, 5);
  RangeValues experienceRange = const RangeValues(1, 30);
  RangeValues distanceRange = const RangeValues(1, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.w(20),
            vertical: AppSizes.h(16),
          ),
          child: Column(
            children: [
              FilterHeader(onBack: () => Navigator.pop(context)),
              SizedBox(height: AppSizes.h(30)),
              Expanded(
                child: SingleChildScrollView(
                  child: FilterForm(
                    selectedCategory: selectedCategory,
                    selectedService: selectedService,
                    categories: categories,
                    services: services,
                    ratingRange: ratingRange,
                    experienceRange: experienceRange,
                    distanceRange: distanceRange,
                    onCategoryChanged: _changeCategory,
                    onServiceChanged: (value) {
                      setState(() => selectedService = value);
                    },
                    onRatingChanged: (value) {
                      setState(() => ratingRange = value);
                    },
                    onExperienceChanged: (value) {
                      setState(() => experienceRange = value);
                    },
                    onDistanceChanged: (value) {
                      setState(() => distanceRange = value);
                    },
                    onApply: _applyFilter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeCategory(String? value) {
    setState(() {
      selectedCategory = value;
      services = ServiceCategories.getServicesByCategory(value ?? '');
      selectedService = null;
    });
  }

  void _applyFilter() {
    Navigator.pop(context, {
      'category': selectedCategory,
      'service': selectedService,
      'ratingStart': ratingRange.start,
      'ratingEnd': ratingRange.end,
      'experienceStart': experienceRange.start,
      'experienceEnd': experienceRange.end,
      'distanceStart': distanceRange.start,
      'distanceEnd': distanceRange.end,
    });
  }
}
