import 'package:song/Models/Profile.dart';
import 'package:song/services/FiresStoreDB.dart';
import 'package:song/services/Locator.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreDB{

  Future<String> getUID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    print("id boş");
    String uid = sharedPreferences.get("UID");

    return uid;
  }

  Future<String> createUID() async{
    var uid = Uuid();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = uid.v1();

    print("created UİD : $id");
    sharedPreferences.setString("UID", id);

    getIt<FireStoreDB>().createUser(id);

    return id;
  }


  Future<void> removeUID() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.clear();
  }

}