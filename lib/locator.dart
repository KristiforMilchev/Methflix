import 'package:application/implementations/authentication_service.dart';
import 'package:application/implementations/configuration.dart';
import 'package:application/implementations/exception_manager.dart';
import 'package:application/implementations/http_provider.dart';
import 'package:application/implementations/local_storage.dart';
import 'package:application/implementations/observer.dart';
import 'package:application/implementations/page_router_service.dart';
import 'package:application/implementations/signature_service.dart';
import 'package:application/implementations/video_stream_service.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:infrastructure/interfaces/iauthentication_service.dart';
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
  getIt.registerSingleton<IHttpProviderService>(HttpProvider());

  getIt.registerSingleton<IExceptionManager>(ExceptionManager());
  getIt.registerSingleton<IObserver>(Observer());
  getIt.registerLazySingleton<IPageRouterService>(() {
    IObserver observer = getIt<IObserver>();
    return PageRouterService(observer);
  });
  getIt.registerSingleton<IlocalStorage>(LocalStorage());
  getIt.registerSingleton<ISignatureService>(SignatureService());

  getIt.registerLazySingleton<IAuthenticationService>(() {
    IHttpProviderService httpProvider = getIt<IHttpProviderService>();
    ISignatureService signatureService = getIt<ISignatureService>();
    IlocalStorage localStorage = getIt<IlocalStorage>();
    return AuthenticationService(signatureService, httpProvider, localStorage);
  });

  var configData = Configuration();
  var config = await configData.getConfig();
  getIt.registerLazySingleton<IVideoStreamService>(() {
    IHttpProviderService httpService = getIt<IHttpProviderService>();
    return VideoStreamService(httpService, config.apiEndpoint);
  });
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
