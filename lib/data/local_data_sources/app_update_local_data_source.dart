import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:aker_foods_retail/data/models/app_force_update_model.dart';
import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';

class AppUpdateLocalDataSource {
  final LocalPreferences localPreferences;

  AppUpdateLocalDataSource({
    @required this.localPreferences,
  });

  AppForceUpdateModel getAppUpdateInfo() {
    try {
      final appUpdateModel =
          localPreferences.get(PreferencesKeys.appUpdateInfo);
      return appUpdateModel == null
          ? null
          : AppForceUpdateModel.fromJson(json.decode(appUpdateModel));
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> setAppUpdateInfo(AppForceUpdateModel appForceUpdateModel) {
    try {
      final appUpdateInfoJson = json.encode(appForceUpdateModel.toJson);
      return localPreferences.set(
          PreferencesKeys.appUpdateInfo, appUpdateInfoJson);
    } catch (error) {
      return Future.value(false);
    }
  }
}
