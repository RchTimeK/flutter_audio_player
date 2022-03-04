/// Created by RongCheng on 2022/3/2.

import 'package:flutter/material.dart';
import 'package:rc_audio/model/music_model.dart';
import 'package:rc_audio/utils/audio_player.dart';
class MusicItem extends StatelessWidget {
  const MusicItem({Key? key,required this.model,required this.callback}) : super(key: key);
  final MusicModel model;
  final Function(int) callback;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> callback(0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        height: 80,
        child: Row(
          children: [
            Image.asset("assets/images/p${model.id}.jpg",width: 64,height: 64,fit: BoxFit.fitWidth,),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name,style: const TextStyle(color: Colors.black87,fontSize: 17),),
                  Text(model.author,style: const TextStyle(color: Colors.black45,fontSize: 14)),
                ],
              ),
            ),
            InkWell(
              onTap: ()=> callback(1),
              child: (AudioPlayerUtil.state == AudioPlayerState.playing) && (AudioPlayerUtil.musicModel?.url == model.url) ?
              const Icon(Icons.pause_circle_outline_outlined,size: 30,color: Colors.black45,) :
              const Icon(Icons.play_circle_outline_outlined,size: 30,color: Colors.black45,),
            )
          ],
        )
      ),
    );
  }
}
