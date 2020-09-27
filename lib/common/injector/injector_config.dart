import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';
import 'package:aker_foods_retail/common/utils/firebase_auth_utils.dart';
import 'package:aker_foods_retail/common/utils/data_connection_util.dart';
import 'package:aker_foods_retail/config/app_update_config.dart';
import 'package:aker_foods_retail/data/local_data_sources/app_update_local_data_source.dart';
import 'package:aker_foods_retail/data/local_data_sources/authentication_local_data_source.dart';
import 'package:aker_foods_retail/data/local_data_sources/cart_local_data_source.dart';
import 'package:aker_foods_retail/data/local_data_sources/user_address_local_data_source.dart';
import 'package:aker_foods_retail/data/remote_data_sources/banner_info_remote_data_source.dart';
import 'package:aker_foods_retail/data/remote_data_sources/app_update_remote_data_source.dart';
import 'package:aker_foods_retail/data/remote_data_sources/cart_remote_data_source.dart';
import 'package:aker_foods_retail/data/remote_data_sources/products_remote_data_source.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_address_remote_data_source.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_order_remote_data_source.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_profile_remote_data_source.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_transaction_remote_datasource.dart';
import 'package:aker_foods_retail/data/repositories/authentication_repository_impl.dart';
import 'package:aker_foods_retail/data/repositories/banner_info_repository_impl.dart';
import 'package:aker_foods_retail/data/repositories/cart_repository_impl.dart';
import 'package:aker_foods_retail/data/repositories/products_repository_impl.dart';
import 'package:aker_foods_retail/data/repositories/user_address_repository_impl.dart';
import 'package:aker_foods_retail/data/repositories/user_order_repository_impl.dart';
import 'package:aker_foods_retail/data/repositories/user_profile_repository_impl.dart';
import 'package:aker_foods_retail/data/repositories/user_transaction_repository_impl.dart';
import 'package:aker_foods_retail/domain/repositories/authentication_repository.dart';
import 'package:aker_foods_retail/domain/repositories/banner_info_repository.dart';
import 'package:aker_foods_retail/domain/repositories/cart_repository.dart';
import 'package:aker_foods_retail/domain/repositories/products_repository.dart';
import 'package:aker_foods_retail/domain/repositories/user_address_repository.dart';
import 'package:aker_foods_retail/domain/repositories/user_order_repository.dart';
import 'package:aker_foods_retail/domain/repositories/user_profile_repository.dart';
import 'package:aker_foods_retail/domain/repositories/user_transaction_repository.dart';
import 'package:aker_foods_retail/domain/usecases/authentication_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/banner_info_usecase.dart';
import 'package:aker_foods_retail/domain/usecases/cart_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/products_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/user_address_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/user_order_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/user_profile_user_case.dart';
import 'package:aker_foods_retail/domain/usecases/user_transaction_use_case.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/data_connection_bloc/data_connection_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/firebase_auth_bloc/firebase_auth_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/products_bloc/products_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/coupons_bloc/coupons_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bloc/dashboard_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/bloc/banner_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address/bloc/change_address_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/enter_new_address/bloc/enter_new_address_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/select_society/bloc/select_society_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/user/bloc/user_profile_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/wallet/bloc/user_transaction_bloc.dart';
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
    _configureCommon();
  }

  /// ============ Register Blocs ============
  @Register.singleton(SnackBarBloc)
  @Register.singleton(DataConnectionBloc)
  @Register.singleton(FirebaseAuthBloc)
  @Register.singleton(DashboardBloc)
  @Register.singleton(CartBloc)
  @Register.factory(SelectSocietyBloc)
  @Register.factory(UserProfileBloc)
  @Register.factory(EnterNewAddressBloc)
  @Register.factory(ChangeAddressBloc)
  @Register.factory(UserTransactionBloc)
  @Register.factory(UserOrderBloc)
  @Register.factory(ProductsBloc)
  @Register.factory(CouponsBloc)
  @Register.factory(BannerBloc)
  void _configureBlocs();

  /// ============ Register UseCases ============
  @Register.factory(AuthenticationUseCase)
  @Register.factory(UserAddressUseCase)
  @Register.factory(UserProfileUseCase)
  @Register.factory(UserTransactionUseCase)
  @Register.factory(UserOrderUseCase)
  @Register.factory(ProductsUseCase)
  @Register.factory(CartUseCase)
  @Register.factory(BannerInfoUseCase)
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
  @Register.factory(
    UserProfileRepository,
    from: UserProfileRepositoryImpl,
  )
  @Register.factory(
    UserTransactionRepository,
    from: UserTransactionRepositoryImpl,
  )
  @Register.factory(
    UserOrderRepository,
    from: UserOrderRepositoryImpl,
  )
  @Register.factory(
    ProductsRepository,
    from: ProductsRepositoryImpl,
  )
  @Register.factory(
    CartRepository,
    from: CartRepositoryImpl,
  )
  @Register.factory(
    BannerInfoRepository,
    from: BannerInfoRepositoryImpl,
  )
  void _configureRepositories();

  /// ============ Register LocalDataSources ============
  @Register.factory(AuthenticationLocalDataSource)
  @Register.factory(UserAddressLocalDataSource)
  @Register.factory(CartLocalDataSource)
  @Register.factory(AppUpdateLocalDataSource)
  void _configureLocalDataSources();

  /// ============ Register RemoteDataSources ============
  @Register.factory(UserAddressRemoteDataSource)
  @Register.factory(UserProfileRemoteDataSource)
  @Register.factory(UserTransactionRemoteDataSource)
  @Register.factory(UserOrderRemoteDataSource)
  @Register.factory(ProductsRemoteDataSource)
  @Register.factory(CartRemoteDataSource)
  @Register.factory(AppUpdateRemoteDataSource)
  @Register.factory(BannerInfoRemoteDataSource)
  void _configureRemoteDataSources();

  /// ============ Register Common Classes ============
  @Register.singleton(DataConnectionUtil)
  @Register.singleton(LocalPreferences)
  @Register.singleton(ApiClient)
  @Register.singleton(FirebaseAuthUtils)
  @Register.factory(AppUpdateConfig)
  void _configureCommon();
}
