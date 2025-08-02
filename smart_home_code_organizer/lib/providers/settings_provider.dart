import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smart_home_code_organizer/services/sembast_service.dart';

part 'settings_provider.g.dart';

@riverpod
FutureOr<String> settings(Ref ref) {
  return SembastApi.getDBPath();
}
