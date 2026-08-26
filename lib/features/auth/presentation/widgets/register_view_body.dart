/// register_view_body.dart
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/components/custom_top_error_message.dart';
import 'package:fixgo/core/components/custom_top_message.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/features/auth/presentation/widgets/register_form_section.dart';
import 'package:fixgo/features/chat/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:fixgo/main.dart';

import '../manager/auth_cubit/auth_cubit.dart';
import '../manager/auth_cubit/auth_state.dart';
import '../utils/auth_message_localizer.dart';
import '../widgets/auth_header.dart';
import 'package:fixgo/l10n/app_localizations.dart';

class RegisterViewBody extends StatefulWidget {
  final bool isWorker;

  const RegisterViewBody({super.key, required this.isWorker});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isCompany = false;
  String? selectedService;
  String? selectedCategory;
  String? selectedYears;

  /// نفس التصميم بدون تغيير UI
  /// فقط ربط البيانات من الملف المركزي
  List<String> _yearsList(AppLocalizations l10n) => [
    l10n.oneYear,
    l10n.twoYears,
    '3 ${l10n.years}',
    '4 ${l10n.years}',
    '5 ${l10n.years}',
    l10n.tenPlusYears,
  ];

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String cleanText(String text) {
    return text
        .replaceAll(' ', '')
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '');
  }

  String normalizePhoneNumber(AppLocalizations l10n) {
    String cleaned = cleanText(phoneController.text);

    /// لازم يكون 9 أرقام
    if (cleaned.length != 8) {
      throw Exception(l10n.phoneNumberNineDigits);
    }

    /// نحول لسعودي
    return "+968$cleaned";
  }

  void _register(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final name = nameController.text.trim();

    if (name.isEmpty) {
      CustomTopErrorMessage.show(context, message: l10n.enterUsername);
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      CustomTopErrorMessage.show(context, message: l10n.enterPhoneNumber);
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      CustomTopErrorMessage.show(context, message: l10n.enterPassword);
      return;
    }

    String phone;
    try {
      phone = normalizePhoneNumber(l10n); // 🔥 أهم سطر
    } catch (e) {
      CustomTopErrorMessage.show(
        context,
        message: e.toString().replaceAll("Exception: ", ""),
      );
      return;
    }

    /// باقي الشروط
    if (widget.isWorker) {
      if (selectedCategory == null ||
          selectedService == null ||
          selectedYears == null) {
        CustomTopErrorMessage.show(
          context,
          message: l10n.completeProviderDetails,
        );
        return;
      }
    }

    context.read<AuthCubit>().register(
      name: name,
      phone: phone,
      password: passwordController.text.trim(),
      type: !widget.isWorker
          ? "user"
          : isCompany
          ? "company"
          : "worker",
      profession: selectedService,
      serviceCategory: selectedCategory,
      yearsOfExperience: widget.isWorker
          ? [1, 2, 3, 4, 5, 10][_yearsList(l10n).indexOf(selectedYears!)]
          : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() {
              isLoading = true;
            });
          }
          if (state is AuthSuccess) {
            setState(() {
              isLoading = false;
            });

            CustomTopMessage.show(
              context,
              type: MessageType.success,
              message: localizeAuthMessage(
                AppLocalizations.of(context),
                state.message,
              ),
            );

            saveFcmToken();

            context.read<AppSessionCubit>().loadUser();
            context.read<ChatsCubit>().getChats();

            Future.delayed(const Duration(milliseconds: 800), () {
              if (!widget.isWorker) {
                context.go("/home/home");
              } else {
                context.go("/location-permission", extra: {"type": "worker"});
              }
            });
          }
          if (state is AuthFailure) {
            setState(() {
              isLoading = false;
            });

            CustomTopErrorMessage.show(
              context,
              message: localizeAuthMessage(
                AppLocalizations.of(context),
                state.message,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthHeader(
                    headerTitle: l10n.login,
                    title: l10n.welcome,
                    subtitle: l10n.enjoyYourJourney,
                    showBack: true,
                    onHeaderTap: () {
                      context.push("/login");
                    },
                  ),

                  const SizedBox(height: 16),
                  RegisterFormSection(
                    nameController: nameController,
                    phoneController: phoneController,
                    passwordController: passwordController,
                    isWorker: widget.isWorker,
                    selectedService: selectedService,
                    selectedCategory: selectedCategory,
                    selectedYears: selectedYears,
                    isCompany: isCompany,
                    yearsList: _yearsList(l10n),
                    onServiceChanged: (value) {
                      setState(() {
                        selectedService = value;
                      });
                    },
                    onCategoryChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        selectedService = null;
                      });
                    },
                    onYearsChanged: (value) {
                      setState(() {
                        selectedYears = value;
                      });
                    },
                    onCompanyChanged: (value) {
                      setState(() {
                        isCompany = value;
                      });
                    },
                  ),

                  const SizedBox(height: 28),

                  CustomButton(
                    text: l10n.createAccount,
                    isLoading: isLoading,
                    onPressed: () => _register(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
