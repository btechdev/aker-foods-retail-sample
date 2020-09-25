import 'dart:io';

import 'package:aker_foods_retail/data/local_data_sources/app_update_local_data_source.dart';
import 'package:aker_foods_retail/data/models/app_force_update_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/app_update_remote_data_source.dart';

class AppUpdateConfig {
  final AppUpdateRemoteDataSource appUpdateRemoteDataSource;
  final AppUpdateLocalDataSource appUpdateLocalDataSource;

  AppUpdateConfig(
      {this.appUpdateRemoteDataSource, this.appUpdateLocalDataSource});

  Future<void> getAppUpdateInfo() async {
    final appUpdateInfoModel = await appUpdateRemoteDataSource.getAppUpdateInfo(
        '1.0', Platform.isIOS ? 'ios' : 'android');
    if (appUpdateInfoModel.version != null) {
      await appUpdateLocalDataSource.setAppUpdateInfo(appUpdateInfoModel);
    } else {
      return;
    }
  }

  AppForceUpdateModel getAppUpdateInfoFromLocal() {
    return appUpdateLocalDataSource.getAppUpdateInfo();
  }
}
