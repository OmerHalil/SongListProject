

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:song/Models/Song.dart';

class FireStoreDB{

   final  db = Firestore.instance;



   Future<List<Song>> getSongs() async {

     List<Song> songs = List<Song>();

     await db.collection("songs")
         .getDocuments().then((QuerySnapshot snapshot) {
           print(snapshot.documents.length);
           snapshot.documents.forEach((element) {
             songs.add(
               Song(
                 band: element.data["track_band"],
                 id: element.documentID,
                 image: element.data["image"],
                 name: element.data["track_name"],
                 year: element.data["release_year"]
               )
             );
           });});

    return songs;
   }


}