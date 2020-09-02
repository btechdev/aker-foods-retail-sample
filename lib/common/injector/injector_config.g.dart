// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => SnackBarBloc());
    container.registerSingleton(
        (c) => FirebaseAuthBloc(authUseCase: c<AuthenticationUseCase>()));
    container.registerSingleton((c) => DashboardBloc());
    container.registerFactory(
        (c) => SelectSocietyBloc(userAddressUseCase: c<UserAddressUseCase>()));
  }

  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => AuthenticationUseCase(
        authenticationRepository: c<AuthenticationRepository>()));
    container.registerFactory((c) =>
        UserAddressUseCase(userAddressRepository: c<UserAddressRepository>()));
  }

  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory<AuthenticationRepository>((c) =>
        AuthenticationRepositoryImpl(
            authenticationLocalDataSource: c<AuthenticationLocalDataSource>()));
    container.registerFactory<UserAddressRepository>((c) =>
        UserAddressRepositoryImpl(
            userAddressRemoteDataSource: c<UserAddressRemoteDataSource>()));
  }

  void _configureLocalDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) =>
        AuthenticationLocalDataSource(localPreferences: c<LocalPreferences>()));
  }

  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => UserAddressRemoteDataSource(apiClient: c<ApiClient>()));
  }

  void _configureClients() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => ApiClient());
  }

  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => LocalPreferences());
  }
}
