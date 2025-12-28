import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BriefcasePage extends StatelessWidget {
  const BriefcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('BriefcasePage')));
  }
}
