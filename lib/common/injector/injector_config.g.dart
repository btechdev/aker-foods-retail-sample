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
  }

  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => AuthenticationUseCase(
        authenticationRepository: c<AuthenticationRepository>()));
  }

  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory<AuthenticationRepository>((c) =>
        AuthenticationRepositoryImpl(
            authenticationLocalDataSource: c<AuthenticationLocalDataSource>()));
  }

  void _configureLocalDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) =>
        AuthenticationLocalDataSource(localPreferences: c<LocalPreferences>()));
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
