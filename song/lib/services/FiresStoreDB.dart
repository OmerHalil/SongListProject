import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:song/Models/Profile.dart';
import 'package:song/Models/Song.dart';
import 'package:song/services/Locator.dart';
import 'package:song/services/SharedPreDB.dart';
import 'package:uuid/uuid.dart';

class FireStoreDB{

   final  db = Firestore.instance;

  final sharedDB = getIt<SharedPreDB>();

   Future<List<Song>> getSongs() async {
     String uid = await sharedDB.getUID();


     List<Song> songs = List<Song>();

     List<String> liked = await  getLikedSongs(uid);
     List<String> disLiked = await  getDisLikedSongs(uid);

      print("liked $liked");
      print("disliked $disLiked");

     await db.collection("songs")
         .getDocuments().then((QuerySnapshot snapshot) {
           print(snapshot.documents.length);
           snapshot.documents.forEach((element) {
             bool isLiked;

             String songId =  element.documentID;

             if(liked.contains(songId)){
               isLiked = true;
             }
             else if(disLiked.contains(songId)){
               isLiked = false;
             }

             songs.add(
               Song(
                 band: element.data["track_band"],
                 id: element.documentID,
                 image: element.data["image"],
                 name: element.data["track_name"],
                 year: element.data["release_year"],
                 isLiked: isLiked
               )
             );
           });});

    return songs;
   }

   Future<List<String>> getLikedSongs(String uid) async {
     List<String> songs = [];

    String path = "profiles/" + uid + "/liked";

    await db.collection(path).getDocuments().then((value) {

      value.documents.forEach((element) {
        String id = element.data["id"];

        songs.add(id);

      });

    });


    return songs;
   }


   Future<List<String>> getDisLikedSongs(String uid) async {
     List<String> songs = [];

     String path = "profiles/" + uid + "/disLiked";

     await db.collection(path).getDocuments().then((value) {

       value.documents.forEach((element) {
         String id = element.data["id"];

         songs.add(id);

       });

     });


     return songs;
   }


   addLikedSong(String uid) async {

     List<String> songs = List<String>();

     await db.collection("profiles")
         .document(uid).
         collection("liked");

   }




   void createUser(String uid) async{
     db.collection("profiles").
     document(uid).
     setData(
       {
         "liked":[],
         "disliked":[]
       }
     );


   }

    likeSongs(String id, bool isLiked) async{
    String uid = await sharedDB.getUID();

     return await db.collection("profiles/$uid/liked").add(
       {
         "id":id
       }
     );

  }

     disLikeSongs(String id, bool isLiked) async{
    String uid = await sharedDB.getUID();

     return await db.collection("profiles/$uid/disLiked").add(
       {
         "id":id
       }
     );

  }

}