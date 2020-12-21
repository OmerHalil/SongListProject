


import 'package:get_it/get_it.dart';
import 'package:song/Pages/HomePage.dart';
import 'package:song/ViewModels/HomePageModel.dart';
import 'package:song/services/FiresStoreDB.dart';
import 'package:song/services/SharedPreDB.dart';

GetIt getIt = GetIt.instance;


void setUpLocator(){
  //Service
  getIt.registerLazySingleton(() => FireStoreDB());
  getIt.registerLazySingleton(() => SharedPreDB());


  //Models
  getIt.registerLazySingleton(() => HomePageModel());


}


