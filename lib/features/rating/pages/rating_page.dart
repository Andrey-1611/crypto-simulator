import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('RatingPage')));
  }
}
