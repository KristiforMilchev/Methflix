import 'package:application/implementations/configuration.dart';
import 'package:application/implementations/exception_manager.dart';
import 'package:application/implementations/http_provider.dart';
import 'package:application/implementations/local_storage.dart';
import 'package:application/implementations/observer.dart';
import 'package:application/implementations/page_router_service.dart';
import 'package:application/implementations/signature_service.dart';
import 'package:application/implementations/video_stream_service.dart';

import 'package:get_it/get_it.dart';
import 'package:infrastructure/interfaces/iconfiguration.dart';
import 'package:infrastructure/interfaces/iexception_manager.dart';
import 'package:infrastructure/interfaces/ihttp_provider_service.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/iobserver.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:infrastructure/interfaces/isignature_service.dart';
import 'package:infrastructure/interfaces/ivideo_stream_service.dart';

GetIt getIt = GetIt.I;
void registerDependency() async {
  Observer observer = Observer();
  LocalStorage localStorage = LocalStorage();
  IHttpProviderService httpService = HttpProvider();
  getIt.registerSingleton<IHttpProviderService>(httpService);

  getIt.registerSingleton<IExceptionManager>(ExceptionManager());
  getIt.registerSingleton<IPageRouterService>(PageRouterService(observer));
  getIt.registerSingleton<IObserver>(observer);
  getIt.registerSingleton<IlocalStorage>(localStorage);
  getIt.registerSingleton<ISignatureService>(SignatureService());

  var configData = Configuration();
  var config = await configData.getConfig();
  getIt.registerSingleton<IVideoStreamService>(
      VideoStreamService(httpService, config.apiEndpoint));
  getIt.registerSingleton<IConfiguration>(configData);
}

void registerFactory<T>(FactoryFunc<T> func) {
  getIt.registerFactory(() => func);
}

void registerSingleton<T>(FactoryFunc<T> instance) {
  getIt.registerSingleton(instance);
}

void registerLazySingleton<T>(FactoryFunc<T> func) {
  getIt.registerLazySingleton(() => func);
}
