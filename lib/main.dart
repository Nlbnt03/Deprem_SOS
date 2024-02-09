import 'package:deprem_uygulamasi/mesajEkrani.dart';
import 'package:deprem_uygulamasi/telefonKayit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:deprem_uygulamasi/buttonDesign.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:screen_brightness/screen_brightness.dart';

void main() {
  TorchController().initialize();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Deprem SOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xffF00000),
        ),
        home:MyHomePage(),
      );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool deger1=true;
  bool deger2=true;
  bool deger3=true;
  bool deger4=true;
  bool deger5=true;
  bool deger6=true;
  bool isik=false;
  bool ses1=false;
  bool ses2=false;
  bool ses3=false;
  bool ses4=false;
  bool ses6=false;
  late AudioPlayer player;
  bool deger_konum=false;
  double enlem=0.0;
  double boylam=0.0;
  @override
  void initState() {
    super.initState();
    setBrightness(0.1);
    VolumeController().setVolume(1.0, showSystemUI: true);
    player = AudioPlayer();
  }
  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
    } catch (e) {
      print(e);
      throw 'Failed to set brightness';
    }
  }
  final controller=TorchController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:GestureDetector(
          onTap: (){
           player.stop();
            Navigator.push(context, MaterialPageRoute(builder: (context) => mesajEkrani(),));
          },
            child: Image.asset("iconlar/mesaj_icons.png")),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: (){
               player.stop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => telefonKayit(),));
              },
                child: Image.asset("iconlar/telefon_icon.png")),
          ),
        ],
        backgroundColor: Color(0xffF00000),
        title:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Deprem SOS",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
          ],
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap:() async {
                        if(deger2==true && deger3==true && deger4==true && ses2==false && ses3==false && ses4==false && ses6==false && deger6==true){
                          setState((){
                            if(deger1==true){
                              deger1=false;
                              ses1=true;
                            }
                            else{
                              deger1=true;
                              ses1=false;
                            }
                          });
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Sadece bir ses seçebilirsiniz"),
                          ));
                        }
                        if(ses1==true && deger3==true && deger2==true && deger4==true && ses2==false && ses3==false && ses4==false && ses6==false && deger6==true){
                        await player.setAsset("assets/audios/Whistlesound.MP3");
                        player.setVolume(1.0);
                        player.play();
                        player.setLoopMode(LoopMode.all);
                        }
                        else if(ses2==true && ses1==false && ses4==false && ses3==false && deger1==true && deger3==true && deger4==true && ses6==false && deger6==true){
                          await player.setAsset("assets/audios/alarmses.mp3");
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else if(ses3==true && deger3==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && ses6==false && deger6==true){
                          await player.setAsset("assets/audios/morsecode.mp3");
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else if(ses4==true && deger4==false && deger3==true && deger2==true && deger1==true && ses2==false && ses1==false && ses3==false && ses6==false && deger6==true){
                          await player.setAsset("assets/audios/yardım.mp3");
                          player.play();
                          player.setVolume(1.0);
                          player.setLoopMode(LoopMode.all);
                        }
                        else if(ses6==true && deger6==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && deger3==true && ses3==false){
                          await player.setAsset("assets/audios/kedi_ses.mp3");
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else{
                          player.stop();
                        }
                      },
                      child: buttonDesign("","iconlar/dudukicon.png", deger1)),
                  GestureDetector(
                      onTap:() async{
                        if(deger1==true && deger3==true && deger4==true && ses1==false && ses3==false && ses4==false && ses6==false && deger6==true){
                          setState(() {
                            if(deger2==true){
                              deger2=false;
                              ses2=true;
                            }
                            else{
                              deger2=true;
                              ses2=false;
                            }
                          });
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Sadece bir ses seçebilirsiniz"),
                          ));
                        }
                        if(ses2==true && ses1==false && ses4==false && ses3==false && deger1==true && deger3==true && deger4==true && ses6==false && deger6==true){
                        await player.setAsset("assets/audios/alarmses.mp3");
                        player.play();
                        player.setLoopMode(LoopMode.all);
                        }
                        else if(ses1==true && deger3==true && deger2==true && deger4==true && ses2==false && ses3==false && ses4==false && ses6==false && deger6==true){
                          await player.setAsset("assets/audios/Whistlesound.MP3");
                          player.setVolume(1.0);
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else if(ses3==true && deger3==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && ses6==false && deger6==true){
                          await player.setAsset("assets/audios/morsecode.mp3");
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else if(ses4==true && deger4==false && deger3==true && deger2==true && deger1==true && ses2==false && ses1==false && ses3==false && ses6==false && deger6==true){
                          await player.setAsset("assets/audios/yardım.mp3");
                          player.play();
                          player.setVolume(1.0);
                          player.setLoopMode(LoopMode.all);
                        }
                        else if(ses6==true && deger6==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && deger3==true && ses3==false){
                          await player.setAsset("assets/audios/kedi_ses.mp3");
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else{
                          player.stop();
                        }
                      },
                      child: buttonDesign("","iconlar/sirenicon.png", deger2)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: buttonDesign("","iconlar/kedi_icon.png", deger6),
                  onTap: () async{
                    if(deger2==true && deger1==true && deger4==true && deger3==true && ses2==false && ses3==false &&ses1==false && ses4==false){
                      setState(() {
                        if(deger6==true){
                          deger6=false;
                          ses6=true;
                        }
                        else{
                          deger6=true;
                          ses6=false;
                        }
                      });
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Sadece bir ses seçebilirsiniz"),
                      ));
                    }
                    if(ses6==true && deger6==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && deger3==true && ses3==false){
                      await player.setAsset("assets/audios/kedi_ses.mp3");
                      player.play();
                      player.setLoopMode(LoopMode.all);
                    }
                    else if(ses3==true && deger3==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && ses6==false && deger6==true){
                      await player.setAsset("assets/audios/morsecode.mp3");
                      player.play();
                      player.setLoopMode(LoopMode.all);
                    }
                    else if(ses2==true && ses1==false && ses4==false && ses3==false && deger1==true && deger3==true && deger4==true && ses6==false && deger6==true){
                      await player.setAsset("assets/audios/alarmses.mp3");
                      player.play();
                      player.setLoopMode(LoopMode.all);
                    }
                    else if(ses1==true && deger3==true && deger2==true && deger4==true && ses2==false && ses3==false && ses4==false && ses6==false && deger6==true){
                      await player.setAsset("assets/audios/Whistlesound.MP3");
                      player.setVolume(1.0);
                      player.play();
                      player.setLoopMode(LoopMode.all);
                    }
                    else if(ses4==true && deger4==false && deger3==true && deger2==true && deger1==true && ses2==false && ses1==false && ses3==false && ses6==false && deger6==true){
                      await player.setAsset("assets/audios/yardım.mp3");
                      player.play();
                      player.setVolume(1.0);
                      player.setLoopMode(LoopMode.all);
                    }
                    else{
                      player.stop();
                    }
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: buttonDesign("","iconlar/morssosicon.png", deger3),
                    onTap: () async{
                      if(deger2==true && deger1==true && deger4==true && ses2==false && ses1==false && ses4==false && ses6==false && deger6==true){
                        setState(() {
                          if(deger3==true){
                            deger3=false;
                            ses3=true;
                          }
                          else{
                            deger3=true;
                            ses3=false;
                          }
                        });
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Sadece bir ses seçebilirsiniz"),
                        ));
                      }
                      if(ses3==true && deger3==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && ses6==false && deger6==true){
                      await player.setAsset("assets/audios/morsecode.mp3");
                      player.play();
                      player.setLoopMode(LoopMode.all);
                      }
                      else if(ses2==true && ses1==false && ses4==false && ses3==false && deger1==true && deger3==true && deger4==true && ses6==false && deger6==true){
                        await player.setAsset("assets/audios/alarmses.mp3");
                        player.play();
                        player.setLoopMode(LoopMode.all);
                      }
                      else if(ses1==true && deger3==true && deger2==true && deger4==true && ses2==false && ses3==false && ses4==false && ses6==false && deger6==true){
                        await player.setAsset("assets/audios/Whistlesound.MP3");
                        player.setVolume(1.0);
                        player.play();
                        player.setLoopMode(LoopMode.all);
                      }
                      else if(ses4==true && deger4==false && deger3==true && deger2==true && deger1==true && ses2==false && ses1==false && ses3==false && ses6==false && deger6==true){
                        await player.setAsset("assets/audios/yardım.mp3");
                        player.play();
                        player.setVolume(1.0);
                        player.setLoopMode(LoopMode.all);
                      }
                      else if(ses6==true && deger6==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && deger3==true && ses3==false){
                        await player.setAsset("assets/audios/kedi_ses.mp3");
                        player.play();
                        player.setLoopMode(LoopMode.all);
                      }
                      else{
                        player.stop();
                      }
                    },
                  ),
                  GestureDetector(
                      onTap: () async{
                        if(deger2==true && deger3==true && deger1==true && ses2==false && ses3==false && ses1==false && ses6==false && deger6==true){
                          setState(() {

                            if(deger4==true){
                              deger4=false;
                              ses4=true;
                            }
                            else{
                              deger4=true;
                              ses4=false;
                            }
                          });
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Sadece bir ses seçebilirsiniz"),
                          ));
                        }
                        if(ses4==true && deger4==false && deger3==true && deger2==true && deger1==true && ses2==false && ses1==false && ses3==false && ses6==false && deger6==true){
                        await player.setAsset("assets/audios/yardım.mp3");
                        player.play();
                        player.setVolume(1.0);
                        player.setLoopMode(LoopMode.all);
                        }
                        else if(ses3==true && deger3==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && ses6==false && deger6==true){
                          await player.setAsset("assets/audios/morsecode.mp3");
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else if(ses2==true && ses1==false && ses4==false && ses3==false && deger1==true && deger3==true && deger4==true && ses6==false && deger6==true){
                          await player.setAsset("assets/audios/alarmses.mp3");
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else if(ses1==true && deger3==true && deger2==true && deger4==true && ses2==false && ses3==false && ses4==false && ses6==false && deger6==true){
                          await player.setAsset("assets/audios/Whistlesound.MP3");
                          player.setVolume(1.0);
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else if(ses6==true && deger6==false && deger4==true && deger2==true && deger1==true && ses2==false && ses1==false && ses4==false && deger3==true && ses3==false){
                          await player.setAsset("assets/audios/kedi_ses.mp3");
                          player.play();
                          player.setLoopMode(LoopMode.all);
                        }
                        else{
                          player.stop();
                        }
                      },
                      child:buttonDesign("","iconlar/yardimsesiicon.png", deger4)),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          isik=!isik;
          controller.toggle();
          setState(()  {
            if(deger5==true){
              deger5=false;
            }
            else{
              deger5=true;
            }
          });

        },
        elevation: 10,
        backgroundColor:deger5? Color(0xffF00000):Color(0xff414345),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("iconlar/lampicon.png")
          ],
        ),
      ),
    );
  }
}
