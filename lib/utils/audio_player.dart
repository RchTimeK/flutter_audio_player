/// Created by RongCheng on 2022/3/2.

import 'package:audioplayers/audioplayers.dart';
import 'package:rc_audio/model/music_model.dart';

class AudioPlayerUtil{

  // ---------------------  public -------------------------
  static MusicModel? get musicModel => _instance._musicModel; // 当前播放的音频模型
  static AudioPlayerState get state => _instance._state; // 当前播放状态
  static Duration get position => _instance._position; // 当前音频播放进度
  static bool get isListPlayer => _instance._isListPlayer; // 当前是否是列表播放
  // 单个播放
  static void playerHandle({required MusicModel model}){
    if(_instance._musicModel == null){ // 播放新的音频
      _instance._playNewAudio(model);
      _instance._isListPlayer = false; // 关闭列表播放
    }else{
      if(_instance._musicModel!.url == model.url){ // 继续当前资源进行播放or暂停
        if(_instance._state == AudioPlayerState.playing){
          _instance._audioPlayer.pause();
        }else{
          _instance._audioPlayer.resume();
        }
      }else{ // 播放新的音频
        _instance._playNewAudio(model);
        _instance._isListPlayer = false; // 关闭列表播放
      }
    }
  }

  // 列表播放
  static void listPlayerHandle({required List<MusicModel> musicModels,MusicModel? musicModel} ){
    if(musicModel != null){ // 指定播放列表中某个曲子。自动开启列表播放
      _instance._playNewAudio(musicModel);
      _instance._musicModels = musicModels;
      _instance._isListPlayer = true;
    }else{
      if(_instance._isListPlayer == true){ // 列表已经开启过。此处破；判断暂停、播放
        if(_instance._state == AudioPlayerState.playing){
          _instance._audioPlayer.pause();
        }else{
          _instance._audioPlayer.resume();
        }
      }else{ // 开启列表播放,从0开始
        _instance._playNewAudio(musicModels.first);
        _instance._musicModels = musicModels;
        _instance._isListPlayer = true;
      }
    }
  }

  // 上一曲 ，只在列表播放时有效
  static void previousMusic(){
    if(_instance._isListPlayer == false) return;
    int index = _instance._musicModels.indexOf(_instance._musicModel!);
    if(index == 0){
      index = _instance._musicModels.length-1;
    }else{
      index -= 1;
    }
    _instance._playNewAudio(_instance._musicModels[index]);
  }

  // 下一曲，只在列表播放时有效
  static void nextMusic(){
    if(_instance._isListPlayer == false) return;
    int index = _instance._musicModels.indexOf(_instance._musicModel!);
    if(index == _instance._musicModels.length-1){ // 最后一首
      index = 0;
    }else{
      index += 1;
    }
    _instance._playNewAudio(_instance._musicModels[index]);
  }

  // 跳转到某一时段
  static void seekTo({required Duration position,required MusicModel model}){
    if(_instance._musicModel == null){ // 先播放新的音频，再跳转
      _instance._playNewAudio(model);
      _instance._seekTo(position);
    }else{
      if(_instance._musicModel!.url == model.url){ // 继续当前资源进行播放or暂停
        _instance._seekTo(position);
      }else{ // 播放新的音频
        _instance._playNewAudio(model);
        _instance._seekTo(position);
      }
    }
  }

  // 获取音频总时长
  static Future<Duration> getAudioDuration({required String url}) async{
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.setUrl(url);
    int milliseconds = await audioPlayer.getDuration();
    return Duration(milliseconds: milliseconds);
  }

  // 播放状态监听
  static void statusListener({required dynamic key,required Function(AudioPlayerState) listener}){
    ListenerStateModel model = ListenerStateModel.fromList([key,listener]);
    _instance._statusPool.add(model);
  }

  // 移除播放状态监听
  static void removeStatusListener(dynamic key){
    _instance._statusPool.removeWhere((element) => element.key == key);
  }

  // 播放进度监听
  static void positionListener({required dynamic key,required Function(int) listener}){
    ListenerPositionModel model = ListenerPositionModel.fromList([key,listener]);
    _instance._positionPool.add(model);
  }

  // 移除播放进度监听
  static void removePositionListener(dynamic key){
    _instance._positionPool.removeWhere((element) => element.key == key);
  }

  // 底部显示tip监听
  static void showListener({required dynamic key,required Function listener}){
    ListenerShowModel model = ListenerShowModel.fromList([key,listener]);
    _instance._showPool.add(model);
  }

  // 移除底部显示tip监听
  static void removeShowListener(dynamic key){
    _instance._showPool.removeWhere((element) => element.key == key);
  }

  // 设置音量
  static Future<int> setVolume(double volume) async{
    return await _instance._audioPlayer.setVolume(volume);
  }

  // 设置播放速度
  static Future<int> setSpeed(double speed) async{
    return await _instance._audioPlayer.setPlaybackRate(speed);
  }

  // 释放资源
  static void dispose(){
    _instance._audioPlayer.release();
    _instance._audioPlayer.dispose();
    _instance._showPool.clear();
    _instance._positionPool.clear();
    _instance._statusPool.clear();
    _instance._musicModel = null;
    _instance._state = AudioPlayerState.stopped;
    _instance._stopPosition = false;
    _instance._position = const Duration(seconds: 0);
    if(_instance._show){
      _instance._show = false;
      _instance._showTipView(false);
    }
  }

  // ---------------------  private ------------------------
  static final AudioPlayerUtil _instance = AudioPlayerUtil._internal();
  factory AudioPlayerUtil() => _instance;
  AudioPlayerUtil._internal(){
    _statusPool = [];
    _positionPool = [];
    _showPool = [];
    _audioPlayer = AudioPlayer();
    // 状态监听
    _audioPlayer.onPlayerStateChanged.listen((PlayerState playerState) {
      switch(playerState){
        case PlayerState.STOPPED:
          // TODO: Handle this case.
          _state = AudioPlayerState.stopped;
          break;
        case PlayerState.PLAYING:
          // TODO: Handle this case.
          _state = AudioPlayerState.playing;
          break;
        case PlayerState.PAUSED:
          // TODO: Handle this case.
          _state = AudioPlayerState.paused;
          break;
        case PlayerState.COMPLETED:
          // TODO: Handle this case.
          _state = AudioPlayerState.completed;
          break;
      }
      _stateUpdate(_state);
    });

    // 播放进度监听
    _audioPlayer.onAudioPositionChanged.listen((Duration  p) {
      _position = p;
      if(p.inSeconds == _secondPosition || _stopPosition == true) return;
      _secondPosition = p.inSeconds;
      for(var element in _positionPool){
        element.listener(p.inSeconds);
      }
    });

    // 播放结束
    _audioPlayer.onPlayerCompletion.listen((_) {
      if(_isListPlayer == true){ // 开启列表播放后，自动下一曲
        nextMusic();
      }else{
        _state = AudioPlayerState.completed;
        _stateUpdate(_state);
      }
    });

    // 播放错误
    _audioPlayer.onPlayerError.listen((_) {
      _resetPlayer();
    });
  }

  AudioPlayerState _state = AudioPlayerState.stopped;
  late AudioPlayer _audioPlayer;
  MusicModel? _musicModel;
  // 创建播放状态监听池
  late List<ListenerStateModel> _statusPool;
  // 播放进度监听池
  late List<ListenerPositionModel> _positionPool;
  // show监听
  late List<ListenerShowModel> _showPool;
  bool _stopPosition = false; // 暂停进度监听，用于seekTo跳转播放缓冲时，Slider停止
  int _secondPosition = 0;
  Duration _position = const Duration(seconds: 0);
  bool _show = false;
  bool _isListPlayer = false;
  List<MusicModel> _musicModels = [];

  // 播放新音频
  void _playNewAudio(MusicModel model) async{
    await _audioPlayer.play(model.url);
    _musicModel = model;
    _showTipView(true);
  }

  // 跳转
  void _seekTo(Duration position) async{
    _stopPosition = true;
    await _audioPlayer.seek(position);
    _stopPosition = false;
  }

  // 更新播放状态
  void _stateUpdate(AudioPlayerState state){
    _state = state;
    for(var element in _statusPool){
      element.listener(state);
    }
  }

  // 开启底部显示tip
  void _showTipView(bool show){
    _show = show;
    for(var element in _showPool){
      element.listener(show);
    }
  }

  // 重置播放器
  void _resetPlayer(){
    if(_state == AudioPlayerState.playing){
      _audioPlayer.pause();
    }
    _audioPlayer.release();
    _secondPosition = 0;
    _state = AudioPlayerState.stopped;
  }
}

// 播放状态监听模型
class ListenerStateModel{
  late dynamic key; /// 根据key标记是谁加入的通知，一般直接传widget就好
  late Function(AudioPlayerState) listener;
  /// 简单写一个构造方法
  ListenerStateModel.fromList(List list){
    key = list.first;
    listener = list.last;
  }
}

// 播放进度监听模型
class ListenerPositionModel{
  late dynamic key; /// 根据key标记是谁加入的通知，一般直接传widget就好
  late Function(int) listener;
  /// 简单写一个构造方法
  ListenerPositionModel.fromList(List list){
    key = list.first;
    listener = list.last;
  }
}

// 底部showTip监听模型
class ListenerShowModel{
  late dynamic key; /// 根据key标记是谁加入的通知，一般直接传widget就好
  late Function(bool) listener;
  /// 简单写一个构造方法
  ListenerShowModel.fromList(List list){
    key = list.first;
    listener = list.last;
  }
}


/// 播放状态枚举
enum AudioPlayerState{
  stopped, // 初始状态，已停止或发生错误
  playing, // 正在播放
  paused,  // 暂停
  completed // 播放结束
}