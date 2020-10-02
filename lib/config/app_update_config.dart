import 'dart:io';

import 'package:aker_foods_retail/data/local_data_sources/app_update_local_data_source.dart';
import 'package:aker_foods_retail/data/models/force_update_data_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/app_update_remote_data_source.dart';

class AppUpdateConfig {
  final AppUpdateRemoteDataSource appUpdateRemoteDataSource;
  final AppUpdateLocalDataSource appUpdateLocalDataSource;

  AppUpdateConfig({
    this.appUpdateRemoteDataSource,
    this.appUpdateLocalDataSource,
  });

  Future<ForceUpdateDataModel> getForceUpdateData(String currentVersion) async {
    final os = Platform.isIOS ? 'ios' : 'android';
    final ForceUpdateDataModel dataModel =
        await appUpdateRemoteDataSource.getForceUpdateData(os, currentVersion);
    /*if (dataModel.version != null) {
      await appUpdateLocalDataSource.setAppUpdateInfo(dataModel);
    }*/
    return dataModel;
  }

  ForceUpdateDataModel getAppUpdateInfoFromLocal() {
    return appUpdateLocalDataSource.getAppUpdateInfo();
  }
}
