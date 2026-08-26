import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixgo/core/di/di.dart';
import 'package:fixgo/features/chat/presentation/widgets/custom_chat_header.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/manager/plans/plans_cubit.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/manager/plans/plans_state.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_plans_content.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_upgrade_button.dart';
import 'package:fixgo/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountBenefitsPage extends StatelessWidget {
  const AccountBenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PlansCubit>()..fetchPlans(),
      child: const AccountBenefitsPageBody(),
    );
  }
}

class AccountBenefitsPageBody extends StatefulWidget {
  const AccountBenefitsPageBody({super.key});

  @override
  State<AccountBenefitsPageBody> createState() =>
      _AccountBenefitsPageBodyState();
}

class _AccountBenefitsPageBodyState extends State<AccountBenefitsPageBody>
    with TickerProviderStateMixin {
  late final AnimationController _headerController;
  late final AnimationController _cardController;
  late final AnimationController _buttonController;
  late final Animation<double> _cardAnimation;
  late final Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _cardAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic),
    );
    _buttonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOutCubic),
    );
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    _headerController.forward();
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    _cardController.forward();
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    _buttonController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _cardController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                CustomChatHeader(
                  title: AppLocalizations.of(context).upgradeAccount,
                  showEditButton: false,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _cardAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - _cardAnimation.value)),
                        child: Opacity(
                          opacity: _cardAnimation.value.clamp(0, 1),
                          child: BlocBuilder<PlansCubit, PlansState>(
                            builder: (context, state) {
                              return AccountPlansContent(
                                state: state,
                                onRetry: _fetchPlans,
                                onRefresh: _fetchPlans,
                                onPlanTap: (plan) =>
                                    _startWhatsAppChat(plan.title),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: AnimatedBuilder(
                animation: _buttonAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _buttonAnimation.value,
                    child: AccountUpgradeButton(
                      onTap: () => _startWhatsAppChat(''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchPlans() async {
    context.read<PlansCubit>().fetchPlans();
  }

  Future<void> _startWhatsAppChat(String message) async {
    final whatsappUri = Uri.parse('https://wa.me/+201068331194?text=$message');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else if (mounted) {
      throw AppLocalizations.of(context).cannotOpenWhatsApp;
    }
  }
}
