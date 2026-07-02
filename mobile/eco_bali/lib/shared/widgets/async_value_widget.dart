import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_view.dart';
import 'loading_indicator.dart';

/// Renders a Riverpod [AsyncValue] using the shared loading/error widgets,
/// so screens only need to provide the success-state UI.
class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const LoadingIndicator(),
      error: (error, _) => ErrorView(error: error, onRetry: onRetry),
    );
  }
}
