import 'package:Bitmark/core/utils/network_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class UnknownError extends StatelessWidget {
  final VoidCallback? onPressed;
  final Object error;

  const UnknownError({super.key, this.onPressed, required this.error});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    final dioError = error is DioException
        ? (error as DioException).error
        : error;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dioError is NoInternetException
                ? s.no_internet_connection
                : s.unknown_error,
            style: theme.textTheme.displayLarge,
          ),
          onPressed != null
              ? TextButton(onPressed: onPressed, child: Text(s.try_again))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
