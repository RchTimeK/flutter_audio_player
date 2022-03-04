/// Created by RongCheng on 2022/3/3.

import 'package:flutter/material.dart';
import 'package:rc_audio/page/detail_page.dart';
import 'dart:ui' as ui show window;

import 'package:rc_audio/utils/audio_player.dart';
class AudioShowView extends StatefulWidget {
  const AudioShowView({Key? key,required this.context}) : super(key: key);
  final BuildContext context;
  @override
  State<AudioShowView> createState() => _AudioShowViewState();
}

class _AudioShowViewState extends State<AudioShowView> {
  bool _show = false;
  late Size _size;
  @override
  void initState() {
    // TODO: implement initState
    _size = MediaQueryData.fromWindow(ui.window).size;
    super.initState();

    AudioPlayerUtil.showListener(key: this, listener: (show){
      if(mounted){
        setState(() {
          _show = show;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return _show ? _showView() : const SizedBox();
  }

  Widget _showView(){
    return InkWell(
      onTap: (){
        Navigator.of(widget.context).push(MaterialPageRoute(
          builder: (context) => DetailPage(musicModel: AudioPlayerUtil.musicModel!),
        ));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
        width: _show == true ?_size.width -20 : 0,
        height: _show == true ?  50 : 0,
        decoration: BoxDecoration(
          color: const Color(0xffaaaaaa),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          children: [
            const SizedBox(width: 8,),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.asset("assets/images/p${AudioPlayerUtil.musicModel!.id}.jpg",width: 40,height: 40,fit: BoxFit.fitWidth,),
            ),
            const SizedBox(width: 8,),
            Expanded(
                child: Text("${AudioPlayerUtil.musicModel!.name} - ${AudioPlayerUtil.musicModel!.author}",style: const TextStyle(color: Colors.white,fontSize: 13),overflow: TextOverflow.ellipsis,)
            ),
            const AudioShowViewButton(),
            const SizedBox(width: 5,),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AudioPlayerUtil.removeShowListener(this);
    super.dispose();
  }
}

class AudioShowViewButton extends StatefulWidget {
  const AudioShowViewButton({Key? key}) : super(key: key);
  @override
  _AudioShowViewButtonState createState() => _AudioShowViewButtonState();
}

class _AudioShowViewButtonState extends State<AudioShowViewButton> {
  late bool _playing;
  @override
  void initState() {
    // TODO: implement initState
    _playing = AudioPlayerUtil.state == AudioPlayerState.playing;
    super.initState();

    // 监听播放状态
    AudioPlayerUtil.statusListener(key: this, listener: (state){
      if(mounted){
        setState(() {
          _playing = state == AudioPlayerState.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AudioPlayerUtil.removeStatusListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> AudioPlayerUtil.playerHandle(model: AudioPlayerUtil.musicModel!),
      child: Icon(_playing ? Icons.pause_circle_outline_outlined :
      Icons.play_circle_outline_outlined,
        size: 40,color: Colors.white,),
    );
  }
}