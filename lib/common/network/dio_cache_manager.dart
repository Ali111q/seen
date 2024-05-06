import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class CacheManager {
  static DioCacheInterceptor manager = DioCacheInterceptor(
    options: CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.refreshForceCache,
      hitCacheOnErrorExcept: [],
      maxStale: const Duration(
        days: 3,
      ),
      priority: CachePriority.high,
    ),
  );
}
