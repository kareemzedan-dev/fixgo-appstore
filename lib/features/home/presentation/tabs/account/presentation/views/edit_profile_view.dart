import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fixgo/core/components/custom_app_bar.dart';
import 'package:fixgo/core/components/custom_button.dart';
import 'package:fixgo/core/session/app_session_cubit.dart';
import 'package:fixgo/core/session/app_session_state.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/edit_profile_fields.dart';
import 'package:fixgo/l10n/app_localizations.dart';

import '../../../../../../auth/presentation/manager/auth_cubit/auth_cubit.dart';
import '../../../../../../auth/presentation/manager/auth_cubit/auth_state.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AppSessionCubit>().state;
      final sep = AppLocalizations.of(context).addressSeparator;
      if (state is AppSessionAuthenticated) {
        nameController.text = state.user.name;
        phoneController.text = state.user.phone;
        phoneController.text = state.user.phone.replaceAll("+968", "");
        addressController.text = [
          state.user.district,
          state.user.city,
        ].where((e) => e != null && e.trim().isNotEmpty).join(sep);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context).editProfile),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 32),

                EditProfileFields(
                  nameController: nameController,
                  phoneController: phoneController,
                  address: addressController.text.isEmpty
                      ? AppLocalizations.of(context).locationNotSet
                      : addressController.text,
                  onEditAddress: () async {
                    final result = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        final tempController = TextEditingController(
                          text: addressController.text,
                        );

                        return AlertDialog(
                          title: Text(AppLocalizations.of(context).editAddress),
                          content: TextField(
                            controller: tempController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(
                                context,
                              ).enterAddress,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(AppLocalizations.of(context).cancel),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, tempController.text),
                              child: Text(AppLocalizations.of(context).save),
                            ),
                          ],
                        );
                      },
                    );

                    if (result != null) {
                      setState(() {
                        addressController.text = result;
                      });
                    }
                  },
                ),

                const SizedBox(height: 28),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) async {
                    if (state is AuthSuccess) {
                      /// 🔥 اعمل refresh للبيانات
                      await context.read<AppSessionCubit>().loadUser();
                      context.go("/home/home");
                    }

                    if (state is AuthFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      text: AppLocalizations.of(context).updateDetails,
                      isLoading: state is AuthLoading,
                      onPressed: () async {
                        final uid = context
                            .read<AppSessionCubit>()
                            .currentUser!
                            .uid;

                        final sessionState = context
                            .read<AppSessionCubit>()
                            .state;

                        String oldPhone = "";
                        if (sessionState is AppSessionAuthenticated) {
                          oldPhone = sessionState.user.phone.replaceAll(
                            "+968",
                            "",
                          );
                        }

                        final newPhone = phoneController.text;

                        /// ✅ لو الرقم اتغير
                        if (newPhone != oldPhone) {
                          final fullPhone = "+968$newPhone";

                          final verificationId = await context
                              .read<AuthCubit>()
                              .sendOtpUseCase
                              .call(fullPhone);

                          /// روح ل OTP
                          context.push(
                            "/otp",
                            extra: {
                              "verificationId": verificationId,
                              "phone": fullPhone,
                              "isUpdate": true, // 🔥 مهم
                            },
                          );

                          return;
                        }

                        /// ✅ لو الرقم متغيرش
                        final parts = addressController.text.split(
                          RegExp(r'[،,]'),
                        );
                        final district = parts.isNotEmpty
                            ? parts[0].trim()
                            : "";
                        final city = parts.length > 1 ? parts[1].trim() : "";

                        context.read<AuthCubit>().updateUser(
                          uid: uid,
                          name: nameController.text,
                          phone: "+968$newPhone",
                          city: city,
                          district: district,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
