import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utility/logger.dart';

class LogObserver extends ProviderObserver {
  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    Log.i('[${provider.name ?? provider.runtimeType}] disposed');
    super.didDisposeProvider(provider, container);
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    Log.i('[${provider.name ?? provider.runtimeType}] created');
    super.didAddProvider(provider, value, container);
  }

  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    Log.i('[${provider.name ?? provider.runtimeType}] updated');
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
