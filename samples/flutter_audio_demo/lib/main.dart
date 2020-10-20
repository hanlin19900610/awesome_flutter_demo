import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_demo/player_widget.dart';
import 'package:provider/provider.dart';

typedef void OnError(Exception exception);

const kUrl1 =
    'http://zipipa.oss-cn-beijing.aliyuncs.com/Uploads/Picture/digvideo/2020-07-28/5f20018e4731a.mp3';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }

    advancedPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      if(s == AudioPlayerState.PLAYING){
        print("开始播放的时间: ${DateTime.now().millisecond}");
      }
      print('Current player state: $s');
    });

    advancedPlayer.onPlayerCompletion.listen((event) {
      print('音频播放完成');
    });
    advancedPlayer.onPlayerCommand.listen((event) {
      print('音频播放完成: $event');
    });
    advancedPlayer.onNotificationPlayerStateChanged.listen((event) {
      print('当前播放器状态: $event');
    });
    advancedPlayer.onDurationChanged.listen((event) {
      print('总播放时长: ${event.inSeconds}');

    });
    advancedPlayer.onAudioPositionChanged.listen((event) {
      print('当前播放位置: ${event.inSeconds}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<Duration>.value(
              initialData: Duration(),
              value: advancedPlayer.onAudioPositionChanged),
        ],
        child: Scaffold(
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sample 1 ($kUrl1)',
                  key: Key('url1'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                RaisedButton(
                  onPressed: () async {
                    print("点击播放的时间: ${DateTime.now().millisecond}");
                    advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
                    await advancedPlayer.play(
                      kUrl1,
                    );
                  },
                  child: Text('播放'),
                ),
                RaisedButton(
                  onPressed: () async {
                    await advancedPlayer.pause();
                  },
                  child: Text('暂停'),
                ),
                RaisedButton(
                  onPressed: () async {
                    await advancedPlayer.stop();
                  },
                  child: Text('停止'),
                ),
                RaisedButton(
                  onPressed: () async {},
                  child: Text('循环播放'),
                ),
              ]),
        ));
  }
}
