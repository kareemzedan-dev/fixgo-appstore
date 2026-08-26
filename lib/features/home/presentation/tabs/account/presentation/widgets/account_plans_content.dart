import 'package:flutter/material.dart';
import 'package:fixgo/features/home/presentation/tabs/account/domain/entities/plan_entity.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/manager/plans/plans_state.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_plan_card.dart';
import 'package:fixgo/features/home/presentation/tabs/account/presentation/widgets/account_plans_states.dart';

class AccountPlansContent extends StatelessWidget {
  const AccountPlansContent({
    required this.state,
    required this.onRetry,
    required this.onRefresh,
    required this.onPlanTap,
    super.key,
  });

  final PlansState state;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;
  final ValueChanged<PlanEntity> onPlanTap;

  @override
  Widget build(BuildContext context) {
    if (state is PlansLoading) {
      return const AccountPlansLoadingState();
    }
    if (state is PlansLoaded) {
      final plans = (state as PlansLoaded).plans;
      if (plans.isEmpty) return const AccountPlansEmptyState();
      return _PlansList(
        plans: plans,
        onRefresh: onRefresh,
        onPlanTap: onPlanTap,
      );
    }
    if (state is PlansError) {
      return AccountPlansErrorState(
        message: (state as PlansError).message,
        onRetry: onRetry,
      );
    }
    return const AccountPlansEmptyState();
  }
}

class _PlansList extends StatelessWidget {
  const _PlansList({
    required this.plans,
    required this.onRefresh,
    required this.onPlanTap,
  });

  final List<PlanEntity> plans;
  final Future<void> Function() onRefresh;
  final ValueChanged<PlanEntity> onPlanTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        color: const Color(0xFF160B48),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: plans.length,
          itemBuilder: (context, index) {
            final plan = plans[index];
            return AnimatedContainer(
              duration: Duration(milliseconds: 300 + (index * 100)),
              curve: Curves.easeOutCubic,
              child: AccountPlanCard(plan: plan, onTap: () => onPlanTap(plan)),
            );
          },
        ),
      ),
    );
  }
}
