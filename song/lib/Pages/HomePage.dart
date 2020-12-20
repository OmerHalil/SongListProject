import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:song/Models/Song.dart';
import 'package:song/Widgets/CustomList%C4%B0tems.dart';
import 'package:song/services/FiresStoreDB.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final model = FireStoreDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("song list"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.all(16),
              child: RaisedButton(
                onPressed: () {
                  model.getSongs();
                },
                child: Text("Liked song list"),
              ),
              ),
              Padding(
                  padding: EdgeInsets.all(16),
              child: RaisedButton(
                onPressed: () {
                  model.getSongs();
                },
                child: Text("Disliked song list"),
              ),
              )
            ],
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
                        return CustomListItem(
                          title: song.name,
                          user: song.band,
                          viewCount: song.year,
                        );
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
}
