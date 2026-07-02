import 'package:flutter/material.dart';

import '../../core/network/api_exception.dart';

/// Standard error/offline state with an optional retry action, used across
/// every feature screen that consumes the backend. Shows a distinct
/// "sin conexión" look when the failure was a connectivity/timeout issue.
class ErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const ErrorView({super.key, required this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final apiError = error is ApiException ? error as ApiException : null;
    final isOffline = apiError?.isConnectivityIssue ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOffline ? Icons.wifi_off_rounded : Icons.cloud_off_outlined,
            size: 40,
            color: colorScheme.error,
          ),
          const SizedBox(height: 12),
          Text(
            apiError?.message ?? error.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ],
      ),
    );
  }
}
