import 'package:get_it/get_it.dart';
import 'core/services/api/api.dart';
import 'core/services/api/fake_api.dart';
import 'core/services/api/http_api.dart';
import 'core/services/api/scaffold_service.dart';
import 'core/viewmodels/all-movies_view_model.dart';
import 'core/viewmodels/authntication_model.dart';
import 'core/viewmodels/home_view_model.dart';

GetIt locator = GetIt.instance;

const bool USE_FAKE_IMPLEMENTATION = false;

void setupLocator() {
  locator.registerLazySingleton<Api>(
      () => USE_FAKE_IMPLEMENTATION ? FakeApi() : HttpApi());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => AllMovieViewModel());
  locator.registerLazySingleton(() => AuthServiceModel());
  locator.registerSingleton(ScaffoldService());
}
