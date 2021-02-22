import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterTts flutterTts = new FlutterTts();

  Future speak() async {
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(_contentss);
    print(_contentss);
  }

  Future stop() async {
    flutterTts.stop();
  }

  String _filepath;
  Future<String> getPath() async {
    _filepath = await FilePicker.getFilePath(
        type: FileType.custom, allowedExtensions: ['txt', 'pdf', 'doc']);
    print('path to file is $_filepath');
    return _filepath;
  }

  void readData() async {
    try {
      new File(_filepath).readAsString().then((String contents) {
        _contentss = contents;
        print(contents);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  var _contentss;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'MY TTS APP',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        )),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: () async {
                  await getPath();
                  readData();
                  speak();
                },
                color: Colors.orange,
                child: Text(
                  'Press Me to speak your file',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            FlatButton(
              child: Text(
                'Press Me to stop speak',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.orange,
              onPressed: () => stop(),
            ),
          ],
        ),
      ),
    ));
  }
}
