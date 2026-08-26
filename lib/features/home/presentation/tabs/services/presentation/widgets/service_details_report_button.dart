import 'package:flutter/material.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:fixgo/core/services/contact_launcher_service.dart';
import 'package:fixgo/core/utils/app_sizes.dart';
import 'package:fixgo/core/utils/colors_manager.dart';

class ServiceDetailsReportButton extends StatelessWidget {
  const ServiceDetailsReportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        ContactLauncherService.openWhatsApp(
          phone: "+201068331194",
          message: "",
        );
      },
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, AppSizes.h(54)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r(16)),
        ),
        side: const BorderSide(color: Color(0xFF1D3964)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.report_gmailerrorred_outlined,
            size: AppSizes.w(18),
            color: const Color(0xFF1D3964),
          ),
          SizedBox(width: AppSizes.w(8)),
          Text(
            AppLocalizations.of(context).reportService,
            style: TextStyle(
              color: ColorsManager.primaryColor,
              fontSize: AppSizes.sp(14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
