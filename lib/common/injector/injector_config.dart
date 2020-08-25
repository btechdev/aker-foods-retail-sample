import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';
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
    /*_configureBlocs();
    _configureUseCases();
    _configureRepositories();
    _configureRemoteDataSources();
    _configureLocalDataSources();
    _configureUtils();
    _configureClients();*/
    _configureCommon();
  }

  /*
  /// ============ Register Blocs ============
  @Register.singleton(AuthenticationBloc)
  @Register.factory(LoginBloc)
  void _configureBlocs();

  /// ============ Register UseCases ============
  @Register.singleton(LoginUseCase)
  void _configureUseCases();

  /// ============ Register Repositories ============
  @Register.singleton(
    LoginRepository,
    from: LoginRepositoryImpl,
  )
  void _configureRepositories();

  /// ============ Register RemoteDataSources ============
  @Register.singleton(LoginRemoteDataSource)
  void _configureRemoteDataSources();

  /// ============ Register LocalDataSources ============
  @Register.singleton(LocalDataSource)
  void _configureLocalDataSources();

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
