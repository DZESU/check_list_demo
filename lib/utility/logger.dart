import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class Log {
  static void i(Object message, {String? tag}) {
    log('(¬‿¬) ${tag ?? ""}: $message');
  }

  static void e(Object message, {String? tag, StackTrace? stackTrack}) {
    log("(╯°□°)╯︵ ┻━┻ ${tag ?? ""}: $message");
    if (stackTrack != null) {
      log(stackTrack.toString());
    }
  }

  static void d(Object message, {String? tag}) {
    if (kDebugMode) {
      log("¯\\_(ツ)_/¯ ${tag ?? ""}: $message");
    }
  }
}
