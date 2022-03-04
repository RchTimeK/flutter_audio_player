/// Created by RongCheng on 2022/3/3.

import 'package:flutter/material.dart';
import 'package:rc_audio/model/music_model.dart';
import 'package:rc_audio/utils/audio_player.dart';

class AudioSlider extends StatefulWidget {
  const AudioSlider({Key? key,required this.musicModel}) : super(key: key);
  final MusicModel musicModel;
  @override
  State<AudioSlider> createState() => _AudioSliderState();
}

class _AudioSliderState extends State<AudioSlider> {

  double _value = 0.0;
  int _total = 0; // 假设总时间为
  String _totalDuration = "00:00";
  String _currentDuration = "00:00";

  @override
  void initState() {
    // TODO: implement initState
    if(AudioPlayerUtil.musicModel != null){
    }
    super.initState();

    // 获取总时长
    AudioPlayerUtil.getAudioDuration(url: widget.musicModel.url).then((duration){
      if(duration.inMilliseconds > 0){
        _total = duration.inSeconds;
        if(mounted){
          setState(() {
            _totalDuration = _updateDuration(duration.inSeconds);
            if(AudioPlayerUtil.musicModel != null){
              if(AudioPlayerUtil.musicModel!.url == widget.musicModel.url){
                _value = AudioPlayerUtil.position.inSeconds / _total;
              }
            }
          });
        }
      }
    });

    // 播放进度回调
    AudioPlayerUtil.positionListener(key: this, listener: (position){
      if(_total == 0) return;
      if(AudioPlayerUtil.musicModel == null) return;
      if(AudioPlayerUtil.musicModel!.url != widget.musicModel.url) return;
      if(mounted){
        setState(() {
          _value = position / _total;
          _currentDuration = _updateDuration(position);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          child: SliderTheme(
            data: const SliderThemeData(
              trackHeight: 8,
              inactiveTrackColor: Colors.black12,
              activeTrackColor: Colors.redAccent,
              trackShape: CustomTrackShape(),
            ),
            child: Slider(
              value: _value,
              onChangeStart: (double value){
                setState(() {
                  _value = value;
                });
              },
              onChangeEnd: (double value){ // 拖拽跳转
                setState(() {
                  _value = value;
                });
                AudioPlayerUtil.seekTo(position: Duration(seconds: (_value*_total).truncate()), model: widget.musicModel);
              },
              onChanged: (double value) {
                setState(() {
                  _value = value;
                });
              },),
          ),
        ),
        Row(
          children: [
            Text(_currentDuration,style: const TextStyle(fontSize: 14,color: Colors.black87),),
            const Spacer(),
            Text(_totalDuration,style: const TextStyle(fontSize: 14,color: Colors.black87),)
          ],
        )
      ],
    );
  }

  String _updateDuration(int second){
    int min = second ~/ 60;
    int sec = second % 60;
    String minString = min < 10 ? "0$min" : min.toString();
    String secString = sec < 10 ? "0$sec" : sec.toString();
    return minString+":"+secString;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AudioPlayerUtil.removePositionListener(this);
    super.dispose();
  }
}
class CustomTrackShape extends RoundedRectSliderTrackShape {
  const CustomTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,}) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackWidth = parentBox.size.width;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}