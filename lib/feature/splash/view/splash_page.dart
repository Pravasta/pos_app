import 'package:flutter/material.dart';

import 'splash_view.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/splash');

  @override
  Widget build(BuildContext context) {
    return SplashView();
  }
}
