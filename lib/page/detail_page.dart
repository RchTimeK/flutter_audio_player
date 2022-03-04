/// Created by RongCheng on 2022/3/3.

import 'package:flutter/material.dart';
import 'package:rc_audio/model/music_model.dart';
import 'dart:ui' as ui show window;
import 'package:rc_audio/widgets/audio_button.dart';
import 'package:rc_audio/widgets/audio_slider.dart';
class DetailPage extends StatelessWidget {
  const DetailPage({Key? key,required this.musicModel}) : super(key: key);
  final MusicModel musicModel;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQueryData.fromWindow(ui.window).size;
    return Scaffold(
      appBar: AppBar(title: Text(musicModel.name),),
      body: Center(
        child: Column(
          children: [
            Container(
              width: size.width*0.6,
              height: size.width*0.6,
              margin: const EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                border: Border.all(width: 10,color: Colors.white),
                borderRadius: BorderRadius.circular(size.width*0.3),
                boxShadow: const [BoxShadow(color: Color(0xffdddddd),offset: Offset(0.0,2.0),blurRadius: 10.0,spreadRadius: 0.0)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width*0.3),
                child: Image.asset("assets/images/p${musicModel.id}.jpg",width: size.width*0.6,height: size.width*0.6,fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 40,),
            AudioButton(musicModel: musicModel),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: AudioSlider(musicModel: musicModel,),
            ),
          ],
        ),
      ),
    );
  }
}
