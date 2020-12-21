import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:song/Models/Song.dart';
import 'package:song/ViewModels/HomePageModel.dart';
import 'package:song/services/Locator.dart';

class CustomListItem extends StatelessWidget {
  CustomListItem({
    this.song,
    this.likeCallback,
    this.disLikedCallback
  });

  final Song song;
  final Function(String, bool) likeCallback;
  final Function(String, bool) disLikedCallback;

  Color lc = Colors.black;
  Color dc = Colors.black;

  @override
  Widget build(BuildContext context) {
    if(song.isLiked == null){

    }
    else if(song.isLiked){
      lc = Colors.green;
    }
    else if(!song.isLiked){
      dc = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: 300,
              height: 100,
              color: Colors.black,
            ),
          ),
          Expanded(
            flex: 2,
            child: _VideoDescription(
              title: song.name,
              user: song.band,
              viewCount: song.year,
            ),
          ),
          Expanded(
            flex: 2,
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.favorite,color: lc,),onPressed: (){
                    print("${song.id} is liked");
                    likeCallback(song.id, song.isLiked);
                  }),
                  IconButton(icon: Icon(Icons.favorite, color: dc), onPressed: (){
                    print("${song.id} is disliked");
                    disLikedCallback(song.id, song.isLiked);
                  })
                ],
              )
          ),
        ],
      ),
    );
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key key,
    this.title,
    this.user,
    this.viewCount,
  }) : super(key: key);

  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            user,
            style: const TextStyle(fontSize: 14.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$viewCount',
            style: const TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}