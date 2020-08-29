import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';
import 'package:aker_foods_retail/data/local_data_source/authentication_local_data_source.dart';
import 'package:aker_foods_retail/data/repositories/auth_repository_impl.dart';
import 'package:aker_foods_retail/domain/repositories/auth_repository.dart';
import 'package:aker_foods_retail/domain/usecases/auth_usecase.dart';
import 'package:aker_foods_retail/presentation/login/bloc/auth_bloc.dart';
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
    /*_configureRemoteDataSources();
    _configureUtils();
    _configureClients();*/
    _configureCommon();
  }

  /// ============ Register Blocs ============
  @Register.factory(AuthBloc)
  void _configureBlocs();

  /// ============ Register UseCases ============
  @Register.factory(AuthUseCase)
  void _configureUseCases();

  /// ============ Register Repositories ============
  @Register.factory(
    AuthRepository,
    from: AuthRepositoryImpl,
  )
  void _configureRepositories();

  /// ============ Register LocalDataSources ============
  @Register.singleton(AuthenticationLocalDataSource)
  void _configureLocalDataSources();

  /*
  /// ============ Register RemoteDataSources ============
  @Register.singleton(LoginRemoteDataSource)
  void _configureRemoteDataSources();

 

  /// ============ Register Clients ============
  @Register.singleton(ApiClient)
  void _configureClients();

  /// ============ Register Utils ============
  @Register.singleton(DeviceInfoUtil)
  void _configureUtils();*/

  /// ============ Register Common Classes ============
  @Register.singleton(LocalPreferences)
  void _configureCommon();
}
