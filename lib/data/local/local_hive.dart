import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../config/hive_config.dart';

class LocalHive {
  Future<void> addHiveF({required String key, required dynamic data}) async {
    try {
      await Hive.box<dynamic>(HiveConfig.boxName).put(key, data);
    } catch (e, stackTrace) {
      debugPrint(" 💥 addHiveF->trycath:$e, stackTrace:$stackTrace");
    }
  }

  Future<dynamic> getHiveF({required String key}) async {
    try {
      return await Hive.box<dynamic>(HiveConfig.boxName).get(key);
    } catch (e, stackTrace) {
      debugPrint(" 💥 getHiveF->trycath:$e, stackTrace:$stackTrace");
      return null;
    }
  }

  Future<void> updateHiveF({required String key, required dynamic data}) async {
    try {
      await Hive.box<dynamic>(HiveConfig.boxName).put(key, data);
    } catch (e, stackTrace) {
      debugPrint(" 💥 updateHiveF->trycath:$e, stackTrace:$stackTrace");
    }
  }

  Future<void> deleteHiveF({required String key}) async {
    try {
      await Hive.box<dynamic>(HiveConfig.boxName).delete(key);
    } catch (e, stackTrace) {
      debugPrint(" 💥 deleteHiveF->trycath:$e, stackTrace:$stackTrace");
    }
  }

  Future<void> clearHiveF() async {
    try {
      await Hive.box<dynamic>(HiveConfig.boxName).clear();
    } catch (e, stackTrace) {
      debugPrint(" 💥 clearHiveF->trycath:$e, stackTrace:$stackTrace");
    }
  }
}
