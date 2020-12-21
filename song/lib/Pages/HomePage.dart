import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:song/Models/Song.dart';
import 'package:song/ViewModels/HomePageModel.dart';
import 'package:song/Widgets/CustomList%C4%B0tems.dart';
import 'package:song/services/FiresStoreDB.dart';
import 'package:song/services/Locator.dart';
import 'package:song/services/SharedPreDB.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final model = getIt<HomePageModel>();
  bool isLogin = false;
  String uid;

  controlUser() async{
    uid = await getIt<SharedPreDB>().getUID();

    if ( uid == null){
      //user silinip tekrar kontrol et bakalım sıkıntı çıkıyor mu
      getIt<SharedPreDB>().createUID();
      setState(() {
        isLogin = true;
      });
    }
    else{
      print("sing in with $uid id");
      isLogin = true;
    }


  }

  likeSong(String id, bool isLiked) async {
    await model.likeSongs(id, isLiked);
    setState(() {});
  }
  disLikeSong(String id, bool isLiked) async {
    await model.disLikeSong(id, isLiked);
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    //getIt<SharedPreDB>().removeUID();
    controlUser();

    if(isLogin){
      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only( left: 16, top: 16),
                    child: RaisedButton(
                      onPressed: () async{
                        model.showLikedList(context);
                      },
                      child: Text("Liked song list"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,top: 16),
                    child: RaisedButton(
                      onPressed: () {
                        model.showDisLikedList(context);

                      },
                      child: Text("Disliked song list"),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: model.getSongs(),
                  builder: (context,AsyncSnapshot<List<Song>> snapshot) {
                    if(snapshot.hasData){
                      List<Song> songs = snapshot.data;

                      return ListView.builder(
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          Song song = songs[index];
                          return CustomListItem(song: song, likeCallback: likeSong, disLikedCallback: disLikeSong,);
                        },);
                    }
                    else{
                      return Center(
                          child: CircularProgressIndicator()                    );
                    }
                  },

                )
            ),
          ],
        ),
      );
    }
    else{
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
