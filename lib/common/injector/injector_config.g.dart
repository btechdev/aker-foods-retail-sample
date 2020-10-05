// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => LoaderBloc());
    container.registerSingleton((c) => SnackBarBloc());
    container.registerSingleton(
        (c) => DataConnectionBloc(dataConnectionUtil: c<DataConnectionUtil>()));
    container.registerSingleton(
        (c) => FirebaseAuthBloc(authUseCase: c<AuthenticationUseCase>()));
    container.registerSingleton((c) => DashboardBloc(
        userProfileUseCase: c<UserProfileUseCase>(),
        userAddressUseCase: c<UserAddressUseCase>()));
    container.registerSingleton((c) => CartBloc(
        loaderBloc: c<LoaderBloc>(),
        snackBarBloc: c<SnackBarBloc>(),
        cartUseCase: c<CartUseCase>(),
        productsUseCase: c<ProductsUseCase>(),
        userOrderUseCase: c<UserOrderUseCase>()));
    container.registerFactory(
        (c) => SelectSocietyBloc(userAddressUseCase: c<UserAddressUseCase>()));
    container.registerFactory((c) => UserProfileBloc(
        userProfileUseCase: c<UserProfileUseCase>(),
        cartUseCase: c<CartUseCase>(),
        userAddressUseCase: c<UserAddressUseCase>()));
    container.registerFactory((c) =>
        EnterNewAddressBloc(userAddressUseCase: c<UserAddressUseCase>()));
    container.registerFactory(
        (c) => ChangeAddressBloc(userAddressUseCase: c<UserAddressUseCase>()));
    container.registerFactory((c) => UserTransactionBloc(
        userTransactionUseCase: c<UserTransactionUseCase>()));
    container.registerFactory((c) => UserOrderBloc(
        snackBarBloc: c<SnackBarBloc>(),
        userOrderUseCase: c<UserOrderUseCase>()));
    container.registerFactory(
        (c) => ProductsBloc(productsUseCase: c<ProductsUseCase>()));
    container
        .registerFactory((c) => CouponsBloc(cartUseCase: c<CartUseCase>()));
    container.registerFactory((c) => BannerBloc(
        bannerInfoUseCase: c<BannerInfoUseCase>(),
        productsUseCase: c<ProductsUseCase>()));
    container.registerFactory(
        (c) => NotificationBloc(notificationUseCase: c<NotificationUseCase>()));
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
    container.registerFactory((c) => CartUseCase(
        cartRepository: c<CartRepository>(),
        userAddressRepository: c<UserAddressRepository>()));
    container.registerFactory((c) =>
        BannerInfoUseCase(bannerInfoRepository: c<BannerInfoRepository>()));
    container.registerFactory((c) => NotificationUseCase(
        notificationRepository: c<NotificationRepository>()));
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
            userProfileRemoteDataSource: c<UserProfileRemoteDataSource>(),
            localPreferences: c<LocalPreferences>()));
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
        cartRemoteDataSource: c<CartRemoteDataSource>(),
        cartLocalDataSource: c<CartLocalDataSource>()));
    container.registerFactory<BannerInfoRepository>((c) =>
        BannerInfoRepositoryImpl(
            bannerInfoRemoteDataSource: c<BannerInfoRemoteDataSource>()));
    container.registerFactory<NotificationRepository>((c) =>
        NotificationRepositoryImpl(
            notificationRemoteDataSource: c<NotificationRemoteDataSource>()));
  }

  void _configureLocalDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) =>
        AuthenticationLocalDataSource(localPreferences: c<LocalPreferences>()));
    container.registerFactory((c) =>
        UserAddressLocalDataSource(localPreferences: c<LocalPreferences>()));
    container.registerFactory((c) => CartLocalDataSource());
    container.registerFactory((c) =>
        AppUpdateLocalDataSource(localPreferences: c<LocalPreferences>()));
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
    container.registerFactory(
        (c) => AppUpdateRemoteDataSource(apiClient: c<ApiClient>()));
    container.registerFactory(
        (c) => BannerInfoRemoteDataSource(apiClient: c<ApiClient>()));
    container.registerFactory(
        (c) => NotificationRemoteDataSource(apiClient: c<ApiClient>()));
  }

  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => DataConnectionUtil());
    container.registerSingleton((c) => LocalPreferences());
    container.registerSingleton((c) => ApiClient(
        localPreferences: c<LocalPreferences>(),
        dataConnectionBloc: c<DataConnectionBloc>(),
        dataConnectionUtil: c<DataConnectionUtil>()));
    container.registerSingleton(
        (c) => FirebaseAuthUtils(authUseCase: c<AuthenticationUseCase>()));
    container.registerFactory((c) => AppUpdateConfig(
        appUpdateRemoteDataSource: c<AppUpdateRemoteDataSource>(),
        appUpdateLocalDataSource: c<AppUpdateLocalDataSource>()));
  }
}
