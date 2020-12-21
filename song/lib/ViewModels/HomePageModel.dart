


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:song/Models/Song.dart';
import 'package:song/services/FiresStoreDB.dart';
import 'package:song/services/Locator.dart';
import 'package:song/services/SharedPreDB.dart';

class HomePageModel {
  final db = getIt<FireStoreDB>();
  final sharedDb = getIt<SharedPreDB>();

  Future<void> showDisLikedList(BuildContext context) async {
    List<Song> songs = [];
    List<Song> s = await db.getSongs();

    s.forEach((element) {
      if(element.isLiked == false){
        songs.add(element);
      }
    });

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(

            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(

              height: 600,
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  Song song = songs[index];
                  return Padding(
                    padding: EdgeInsets.only(left: 32,top: 32),
                    child: Text(
                      "${song.name}",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  );
                },
              )
              ),
            );
        });
  }

  Future<void> showLikedList(BuildContext context) async {
    List<Song> songs = [];
    List<Song> s = await db.getSongs();

    s.forEach((element) {
      if(element.isLiked == true){
        songs.add(element);
      }
    });
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(

            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(

                height: 600,
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    Song song = songs[index];
                    return Padding(
                      padding: EdgeInsets.only(left: 32,top: 32),
                      child: Text(
                        "${song.name}",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    );
                  },
                )
            ),
          );
        });


  }

  void addLikedSong() async{
    String uid = await sharedDb.getUID();

    db.getLikedSongs(uid);
  }

  Future<List<Song>> getSongs() {
    return db.getSongs();

  }

  Future<void> likeSongs(String id, bool isLiked) async {
    return await db.likeSongs(id, isLiked);
  }

  Future<void> disLikeSong(String id, bool isLiked)  async{
    return await db.disLikeSongs(id, isLiked);
  }




}