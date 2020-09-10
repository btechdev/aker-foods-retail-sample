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
    container.registerFactory(
        (c) => UserProfileBloc(userProfileUseCase: c<UserProfileUseCase>()));
    container.registerFactory((c) =>
        EnterNewAddressBloc(userAddressUseCase: c<UserAddressUseCase>()));
  }

  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => AuthenticationUseCase(
        authenticationRepository: c<AuthenticationRepository>()));
    container.registerFactory((c) =>
        UserAddressUseCase(userAddressRepository: c<UserAddressRepository>()));
    container.registerFactory((c) =>
        UserProfileUseCase(userProfileRepository: c<UserProfileRepository>()));
  }

  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory<AuthenticationRepository>((c) =>
        AuthenticationRepositoryImpl(
            authenticationLocalDataSource: c<AuthenticationLocalDataSource>(),
            apiClient: c<ApiClient>()));
    container.registerFactory<UserAddressRepository>((c) =>
        UserAddressRepositoryImpl(
            userAddressRemoteDataSource: c<UserAddressRemoteDataSource>()));
    container.registerFactory<UserProfileRepository>((c) =>
        UserProfileRepositoryImpl(
            userProfileRemoteDataSource: c<UserProfileRemoteDataSource>()));
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
    container.registerFactory(
        (c) => UserProfileRemoteDataSource(apiClient: c<ApiClient>()));
  }

  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => ApiClient());
    container.registerSingleton((c) => LocalPreferences());
    container.registerSingleton(
        (c) => FirebaseAuthUtils(authUseCase: c<AuthenticationUseCase>()));
  }
}
