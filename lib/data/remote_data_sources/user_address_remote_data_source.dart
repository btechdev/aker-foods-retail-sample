import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';

class UserAddressRemoteDataSource {
  final ApiClient apiClient;

  UserAddressRemoteDataSource({this.apiClient});

  Future<List<SocietyModel>> getSocieties() async {
    /*final map = apiClient.getSocieties();
  	return SocietyModel.fromListJson(map);*/
    // TODO(Bhushan): Remove when API integrated
    return List()
      ..add(SocietyModel(id: '1', name: 'Society 1'))
      ..add(SocietyModel(id: '2', name: 'Society 2'))
      ..add(SocietyModel(id: '3', name: 'Society 3'))
      ..add(SocietyModel(id: '4', name: 'Society 4'))
      ..add(SocietyModel(id: '5', name: 'Society 5'))
      ..add(SocietyModel(id: '6', name: 'Society 6'));
  }
}
