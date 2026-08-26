import 'package:flutter/material.dart';
import 'package:fixgo/features/home/presentation/tabs/home/presentation/widgets/home_tab_view_body.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: HomeTabViewBody()));
  }
}
