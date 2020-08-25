# aker_foods_retail

Aker Foods Retail B2C Mobile Application.

## Getting Started

A few resources to get you started if this is your first Flutter project:
- [Online Documentation](https://flutter.dev/docs)
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

## How to run the app

* Update the desired values of keys in `tools/config.json`
	=> Mandatory Keys:
	=> Optional Keys:

* Set Environment in local by running following command:
	=> `export environment=dev` [dev / qa / prod]

* Generate the local `.env` file having the complete environment, by running:
	=> `dart tools/env.dart` (You will see `lib/.env.dart` is updated)

* Run flutter application:
	=> `flutter run` or `flutter run -d <deviceID>`


## Dependency Injection

* [Kiwi](https://pub.dev/packages/kiwi) as Inversion of Control (IoC) container for our Dependencies Injection
* [kiwi-generator](https://pub.dev/packages/kiwi_generator) for auto-generating the code viz., dependencies graph.

### Steps to follow:

1. Add your dependencies(Bloc, UseCase, Repository, DataSource, etc.) in `injector.dart` as follows:

```dart
  @Register.factory(LoginBloc)
  @Register.singleton(UserBloc)
  void _configureBlocs();

  @Register.factory(LoginUseCase)
  void _configureUseCases();

  @Register.singleton(ApiClient)
  void _configureCommon();
```

2. Auto generate the code of dependencies graph for the application, by running following:

```sh
flutter packages pub run build_runner build --delete-conflicting-outputs
```
Note: `--delete-conflicting-outputs` is optional to override the conflicts in the graph.

3. You will get a dependencies graph generated in `lib/common/injector/injector.g.dart`

4. As `UseCases` belong to domain layer and takes `abstract Repository` class as dependency, provide the mapping of
implementation of repository class while registering, as follows:

```dart
  @Register.singleton(
    UserRepository,
    from: UserRepositoryImpl,
  )
  void _configureRepositories();
```

5. In your widgets or anywhere else, resolve the dependency using `Injector` as follows:

```dart
loginBloc = Injector.resolve<LoginBloc>()
apiClient = Injector.resolve<ApiClient>();
```
