/// Created by RongCheng on 2022/3/3.

import 'package:flutter/material.dart';
import 'package:rc_audio/model/music_model.dart';
import 'package:rc_audio/utils/audio_player.dart';

class AudioButton extends StatefulWidget {
  const AudioButton({Key? key,required this.musicModel}) : super(key: key);
  final MusicModel musicModel;
  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {

  bool _playing = false;

  @override
  void initState() {
    // TODO: implement initState
    // 判断是否正在播放
    if( (AudioPlayerUtil.state == AudioPlayerState.playing) &&
        (AudioPlayerUtil.musicModel != null) &&
        (AudioPlayerUtil.musicModel!.url == widget.musicModel.url)){
      _playing = true;
    }
    super.initState();

    // 监听播放状态
    AudioPlayerUtil.statusListener(key: this, listener: (state){
      if((AudioPlayerUtil.musicModel != null) && (AudioPlayerUtil.musicModel!.url == widget.musicModel.url)){ // 为当前资源
        if(mounted){
          setState(() {
            _playing = state == AudioPlayerState.playing;
          });
        }
      }else{ // 不是当前资源，若当前正在播放，则暂停
        if(_playing == true){
          if(mounted){
            setState(() {
              _playing == false;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> AudioPlayerUtil.playerHandle(model: widget.musicModel),
      child: Icon(_playing ? Icons.pause_circle_outline_outlined :
      Icons.play_circle_outline_outlined,
        size: 80,color: Colors.redAccent,),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AudioPlayerUtil.removeStatusListener(this);
    super.dispose();
  }
}
