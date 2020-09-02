import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';
import 'package:aker_foods_retail/data/local_data_sources/authentication_local_data_source.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_address_remote_data_source.dart';
import 'package:aker_foods_retail/data/repositories/authentication_repository_impl.dart';
import 'package:aker_foods_retail/data/repositories/user_address_repository_impl.dart';
import 'package:aker_foods_retail/domain/repositories/authentication_repository.dart';
import 'package:aker_foods_retail/domain/repositories/user_address_repository.dart';
import 'package:aker_foods_retail/domain/usecases/authentication_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/user_address_use_case.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/presentation/common_blocs/firebase_auth_bloc/firebase_auth_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bloc/dashboard_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/select_society/bloc/select_society_bloc.dart';
import 'package:kiwi/kiwi.dart';

part 'injector_config.g.dart';

abstract class InjectorConfig {
  static KiwiContainer container;

  static void setup() {
    container = KiwiContainer();
    final injector = _$InjectorConfig();
    // ignore: cascade_invocations
    injector._configure();
  }

  // ignore: type_annotate_public_apis
  static final resolve = container.resolve;

  void _configure() {
    _configureBlocs();
    _configureUseCases();
    _configureRepositories();
    _configureLocalDataSources();
    _configureRemoteDataSources();
    _configureClients();
    _configureCommon();
  }

  /// ============ Register Blocs ============
  @Register.singleton(SnackBarBloc)
  @Register.singleton(FirebaseAuthBloc)
  @Register.singleton(DashboardBloc)
  @Register.factory(SelectSocietyBloc)
  void _configureBlocs();

  /// ============ Register UseCases ============
  @Register.factory(AuthenticationUseCase)
  @Register.factory(UserAddressUseCase)
  void _configureUseCases();

  /// ============ Register Repositories ============
  @Register.factory(
    AuthenticationRepository,
    from: AuthenticationRepositoryImpl,
  )
  @Register.factory(
    UserAddressRepository,
    from: UserAddressRepositoryImpl,
  )
  void _configureRepositories();

  /// ============ Register LocalDataSources ============
  @Register.factory(AuthenticationLocalDataSource)
  void _configureLocalDataSources();

  /// ============ Register RemoteDataSources ============
  @Register.factory(UserAddressRemoteDataSource)
  void _configureRemoteDataSources();

  /// ============ Register Clients ============
  @Register.singleton(ApiClient)
  void _configureClients();

  /// ============ Register Common Classes ============
  @Register.singleton(LocalPreferences)
  void _configureCommon();
}
