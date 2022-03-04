/// Created by RongCheng on 2022/3/2.

import 'package:rc_audio/model/music_model.dart';
class MusicDataUtil{

  static List<MusicModel> getMusicData(){
    List<MusicModel> list = [];
    for(Map<String,dynamic> map in _json){
      MusicModel model = MusicModel.fromMap(map);
      list.add(model);
    }
    return list;
  }

  static final List<Map<String,dynamic>> _json = [
    {
      "id":1,
      "name":"城南花已开",
      "author":"三亩地",
      "thumbnail":"https://p1.music.126.net/i-7ktILRPImJ0NwiH8DABg==/109951162885959979.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=468176711.mp3"
    },
    {
      "id":2,
      "name":"My Soul",
      "author":"July",
      "thumbnail":"https://p1.music.126.net/NFl1s5Hl3E37dCaFIDHfNw==/727876697598920.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=5308028.mp3"
    },
    {
      "id":3,
      "name":"風の住む街（风居住的街道）",
      "author":"磯村由紀子",
      "thumbnail":"https://p1.music.126.net/ap7KvRE0-V4kfThDVVor9A==/18777459579736085.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=586299.mp3"
    },
    {
      "id":4,
      "name":"The truth that you leave",
      "author":"Pianoboy高至豪",
      "thumbnail":"https://p1.music.126.net/9idkdzbel_-lYBP7Dv_dVQ==/102254581395289.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=139774.mp3"
    },
    {
      "id":5,
      "name":"You Approaching",
      "author":"Nirvana",
      "thumbnail":"https://p1.music.126.net/C71zjT6CpHzqcRFObJO4Rg==/109951165319954700.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=3932159.mp3"
    },
    {
      "id":6,
      "name":"A Little Story",
      "author":"Valentin",
      "thumbnail":"https://p1.music.126.net/WDUPJR39CqZrzVgAQbQOZg==/109951167082640661.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=857896.mp3"
    },
    {
      "id":7,
      "name":"Illusionary Daytime",
      "author":"Shirfine",
      "thumbnail":"https://p2.music.126.net/8xNVCemkSNQptEyNw1PHKg==/8914840278033758.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=28907016.mp3"
    },
    {
      "id":8,
      "name":"Rain after Summer",
      "author":"羽肿",
      "thumbnail":"https://p1.music.126.net/0qSEuzSqPNrACMPoGy8efw==/109951162863729074.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=430685732.mp3"
    },
    {
      "id":9,
      "name":"いつも何度でも （永远同在）",
      "author":"宗次郎",
      "thumbnail":"https://p1.music.126.net/ygxAeYxxXPONww041tylMw==/5996736418028563.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=480353.mp3"
    },
    {
      "id":10,
      "name":"Asphyxia（Piano Ver.）",
      "author":"逆时针向",
      "thumbnail":"https://p2.music.126.net/FRIgNtiwVBjHDIlhgnzGew==/109951163869607960.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=527957820.mp3"
    },
    {
      "id":11,
      "name":"花火が瞬く夜に",
      "author":"羽肿",
      "thumbnail":"https://p1.music.126.net/ygxAeYxxXPONww041tylMw==/5996736418028563.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=434902428.mp3"
    },
    {
      "id":12,
      "name":"With an Orchid",
      "author":"Yanni",
      "thumbnail":"https://p1.music.126.net/7fgnozyzD3e-flaQO-W2zQ==/109951164936091373.jpg",
      "url":"https://music.163.com/song/media/outer/url?id=20744788.mp3"
    },
  ];
}

/*
 1 城南花已开 三亩地 https://music.163.com/song/media/outer/url?id=468176711.mp3  http://p1.music.126.net/i-7ktILRPImJ0NwiH8DABg==/109951162885959979.jpg

 2 My Soul July  https://music.163.com/song/media/outer/url?id=5308028.mp3  http://p1.music.126.net/NFl1s5Hl3E37dCaFIDHfNw==/727876697598920.jpg

 3 風の住む街（风居住的街道）  磯村由紀子  https://music.163.com/song/media/outer/url?id=586299.mp3  http://p1.music.126.net/ap7KvRE0-V4kfThDVVor9A==/18777459579736085.jpg

 4 The truth that you leave  Pianoboy高至豪  https://music.163.com/song/media/outer/url?id=139774.mp3  https://p1.music.126.net/9idkdzbel_-lYBP7Dv_dVQ==/102254581395289.jpg

 5 You Approaching Nirvana  https://music.163.com/song/media/outer/url?id=3932159.mp3  http://p1.music.126.net/C71zjT6CpHzqcRFObJO4Rg==/109951165319954700.jpg

 6 A Little Story  Valentin  https://music.163.com/song/media/outer/url?id=857896.mp3 https://p1.music.126.net/WDUPJR39CqZrzVgAQbQOZg==/109951167082640661.jpg

 7 Illusionary Daytime （幻昼）  Shirfine  https://music.163.com/song/media/outer/url?id=28907016.mp3  https://p2.music.126.net/8xNVCemkSNQptEyNw1PHKg==/8914840278033758.jpg

 8 Rain after Summer 羽肿 https://music.163.com/song/media/outer/url?id=430685732.mp3   https://p1.music.126.net/0qSEuzSqPNrACMPoGy8efw==/109951162863729074.jpg

 9 いつも何度でも （永远同在）宗次郎 https://music.163.com/song/media/outer/url?id=480353.mp3   https://p1.music.126.net/ygxAeYxxXPONww041tylMw==/5996736418028563.jpg

 10 Asphyxia（Piano Ver.） 逆时针向  https://music.163.com/song/media/outer/url?id=527957820.mp3   https://p2.music.126.net/FRIgNtiwVBjHDIlhgnzGew==/109951163869607960.jpg

 11 花火が瞬く夜に 羽肿 https://music.163.com/song/media/outer/url?id=434902428.mp3  https://p2.music.126.net/f7Nd9FSzVZMkTPWDW_rnOg==/736672800839982.jpg

 12 With an Orchid    Yanni  https://music.163.com/song/media/outer/url?id=20744788.mp3   https://p1.music.126.net/7fgnozyzD3e-flaQO-W2zQ==/109951164936091373.jpg
 */