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
    container.registerSingleton((c) => CartBloc(c<CartUseCase>()));
    container.registerFactory(
        (c) => SelectSocietyBloc(userAddressUseCase: c<UserAddressUseCase>()));
    container.registerFactory(
        (c) => UserProfileBloc(userProfileUseCase: c<UserProfileUseCase>()));
    container.registerFactory((c) =>
        EnterNewAddressBloc(userAddressUseCase: c<UserAddressUseCase>()));
    container.registerFactory(
        (c) => ChangeAddressBloc(userAddressUseCase: c<UserAddressUseCase>()));
    container.registerFactory((c) => UserTransactionBloc(
        userTransactionUseCase: c<UserTransactionUseCase>()));
    container.registerFactory(
        (c) => UserOrderBloc(userOrderUseCase: c<UserOrderUseCase>()));
    container.registerFactory(
        (c) => ProductsBloc(productsUseCase: c<ProductsUseCase>()));
    container
        .registerFactory((c) => CouponsBloc(cartUseCase: c<CartUseCase>()));
  }

  void _configureUseCases() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => AuthenticationUseCase(
        authenticationRepository: c<AuthenticationRepository>()));
    container.registerFactory((c) =>
        UserAddressUseCase(userAddressRepository: c<UserAddressRepository>()));
    container.registerFactory((c) =>
        UserProfileUseCase(userProfileRepository: c<UserProfileRepository>()));
    container.registerFactory((c) => UserTransactionUseCase(
        userTransactionRepository: c<UserTransactionRepository>()));
    container.registerFactory(
        (c) => UserOrderUseCase(userOrderRepository: c<UserOrderRepository>()));
    container.registerFactory((c) => ProductsUseCase(c<ProductsRepository>()));
    container.registerFactory(
        (c) => CartUseCase(cartRepository: c<CartRepository>()));
  }

  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory<AuthenticationRepository>((c) =>
        AuthenticationRepositoryImpl(
            authenticationLocalDataSource: c<AuthenticationLocalDataSource>(),
            apiClient: c<ApiClient>()));
    container.registerFactory<UserAddressRepository>((c) =>
        UserAddressRepositoryImpl(
            userAddressRemoteDataSource: c<UserAddressRemoteDataSource>(),
            userAddressLocalDataSource: c<UserAddressLocalDataSource>()));
    container.registerFactory<UserProfileRepository>((c) =>
        UserProfileRepositoryImpl(
            userProfileRemoteDataSource: c<UserProfileRemoteDataSource>()));
    container.registerFactory<UserTransactionRepository>((c) =>
        UserTransactionRepositoryImpl(
            userTransactionRemoteDataSource:
                c<UserTransactionRemoteDataSource>()));
    container.registerFactory<UserOrderRepository>((c) =>
        UserOrderRepositoryImpl(
            userOrderRemoteDataSource: c<UserOrderRemoteDataSource>()));
    container.registerFactory<ProductsRepository>((c) => ProductsRepositoryImpl(
        productsRemoteDataSource: c<ProductsRemoteDataSource>()));
    container.registerFactory<CartRepository>((c) => CartRepositoryImpl(
        cartLocalDataSource: c<CartLocalDataSource>(),
        cartRemoteDataSource: c<CartRemoteDataSource>()));
  }

  void _configureLocalDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) =>
        AuthenticationLocalDataSource(localPreferences: c<LocalPreferences>()));
    container.registerFactory((c) =>
        UserAddressLocalDataSource(localPreferences: c<LocalPreferences>()));
    container.registerFactory((c) => CartLocalDataSource());
  }

  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory(
        (c) => UserAddressRemoteDataSource(apiClient: c<ApiClient>()));
    container.registerFactory(
        (c) => UserProfileRemoteDataSource(apiClient: c<ApiClient>()));
    container.registerFactory(
        (c) => UserTransactionRemoteDataSource(apiClient: c<ApiClient>()));
    container.registerFactory(
        (c) => UserOrderRemoteDataSource(apiClient: c<ApiClient>()));
    container.registerFactory(
        (c) => ProductsRemoteDataSource(apiClient: c<ApiClient>()));
    container.registerFactory(
        (c) => CartRemoteDataSource(apiClient: c<ApiClient>()));
  }

  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => ApiClient());
    container.registerSingleton((c) => LocalPreferences());
    container.registerSingleton(
        (c) => FirebaseAuthUtils(authUseCase: c<AuthenticationUseCase>()));
  }
}
