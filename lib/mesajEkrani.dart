import 'dart:io';

import 'package:deprem_uygulamasi/main.dart';
import 'package:deprem_uygulamasi/telefonKayit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
class mesajEkrani extends StatefulWidget {
  @override
  State<mesajEkrani> createState() => _mesajEkraniState();
}

class _mesajEkraniState extends State<mesajEkrani> {
  List<String> tel_nolar = [];
  String no1="";
  String no2="";
  bool deger_konum=false;
  double enlem=0.0;
  double boylam=0.0;
  bool deger5=true;
  late AudioPlayer player;
  final Telephony telephony=Telephony.instance;
@override
  void dispose() {
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    player=AudioPlayer();
    konumAl();
  }
  Future<void> konumAl() async {
    await Geolocator.requestPermission();
    var konum = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      enlem=konum.latitude;
      boylam=konum.longitude;
    });
    deger_konum=!deger_konum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF00000),
        title: Text("Deprem SOS",style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Şuanki güncel durumunuz uygulamaya kaydettiğiniz telefon numaralarına gönderilecektir "
                    "Enkazın altında iseniz soldaki butona basınız , Güvende iseniz sağdaki butona basınız !",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 20,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0,left: 15.0,right: 15.0),
                child: Text("(Mesajların gönderilebilmesi için konum ve sms izninin verilmesi gereklidir !)",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF00000),
                  fontSize: 15,
                ),textAlign: TextAlign.center,),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async{
                 showDialog(
                    context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                       title: Text("Uyarı Mesajı !",style:TextStyle(
                         fontWeight: FontWeight.bold,
                         color: Color(0xffF00000),
                       ),),
                       content: Text("Enkaz Altında bulunduğunuza dair butona basmış bulunmaktasınız "
                           "sisteme kaydettiğiniz telefon numaralarına güncel durumunuz ve konumunuz mesaj gönderilecektir.",style:TextStyle(
                         fontWeight: FontWeight.bold
                       ),),
                       actions: [
                         TextButton(
                           child: Text("İptal",style: TextStyle(
                             color: Color(0xffF00000),
                             fontWeight: FontWeight.bold,
                           ),),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         ),
                         TextButton(
                           child: Text("Mesaj Gönder",style: TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Color(0xffF00000),
                           ),),
                           onPressed: () async {
                             SharedPreferences prefs1=await SharedPreferences.getInstance();
                             no1=prefs1.getString("phoneNumber1")??"";
                             no2=prefs1.getString("phoneNumber2")??"";
                             if(no1=="" || no2==""){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                 return AlertDialog(
                                    title: Text("Uyarı Mesajı !",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffF00000),
                                    ),),
                                    content: Text("Acil durum numaralarını girmemiş veya eksik girmişsiniz. "
                                        "Bu yüzden telefon kayıt sayfasına dönüp 2 numarayıda belirtilen şekilde giriniz .",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    actions: [
                                      TextButton(
                                        onPressed: (){
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mesajEkrani()));
                                        },
                                        child: Text("İptal",style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffF00000),
                                        ),),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => telefonKayit(),));
                                        },
                                        child: Text("Telefon Kaydet",style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffF00000),
                                        ),),
                                      )
                                    ],
                                  );
                                },
                              );
                             }
                             else{
                               if(enlem==0.0 && boylam==0.0){
                                 ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    content: Text("Konum hesaplanamamış veya izin verilmemiş"),
                                   )
                                 );
                                 Navigator.pop(context);
                               }
                              else {
                                await telephony.sendSms(to: no1, message: "Bu Mesaj Deprem SOS uygulamasından gönderilmektedir.Enkaz altındayım !");
                                await telephony.sendSms(to: no1, message: "Şuanki konumum : https://www.google.com/maps?daddr=${enlem},${boylam}");
                                await telephony.sendSms(to: no2, message: "Bu Mesaj Deprem SOS uygulamasından gönderilmektedir.Enkaz altındayım !");
                                await telephony.sendSms(to: no2, message: "Şuanki konumum : https://www.google.com/maps?daddr=${enlem},${boylam}");
                                await  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Mesaj Gönderildi"),
                                    )
                                );
                               showDialog(
                                 context: context,
                                 builder: (BuildContext context){
                                   return AlertDialog(
                                     title: Text("Uyarı Mesajı",style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       color: Color(0xffF00000),
                                     ),),
                                     content: Text("Uygulamamıza göre mesajlar kaydedilen numaralara gönderilmiştir fakat gönderilip gönderilmediğini kontrol "
                                         "etmeniz için uygulama kapatılacaktır.Kontrolden sonra tekrar dönebilirsiniz .",style: TextStyle(
                                       fontWeight: FontWeight.bold
                                     ),),
                                     actions: [
                                       TextButton(
                                        onPressed: (){
                                          exit(0);
                                        },
                                         child: Text("Tamam",style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xffF00000),),),
                                       ),
                                     ],
                                   );
                                 }
                               );
                               }
                             }
                            }
                         )
                       ],
                     );
                   },
                 );
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0,10.0),
                          blurRadius: 10.0,
                        )
                      ],
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:[Color(0xffF00000),Color(0xffDC281E)],
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 125,
                          height: 125,
                          child: Image.asset("iconlar/acil_icon.png")),
                    ],
                  ),
                ),
              ),
              GestureDetector(
              onTap: () async{
              showDialog(
              context: context,
              builder: (BuildContext context) {
              return AlertDialog(
              title: Text("Uyarı Mesajı !",style:TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffF00000),
              ),),
              content: Text("Güvende bulunduğunuza dair butona basmış bulunmaktasınız "
              "sisteme kaydettiğiniz telefon numaralarına güncel durumunuz ve konumunuz mesaj gönderilecektir.",style:TextStyle(
              fontWeight: FontWeight.bold
              ),),
              actions: [
              TextButton(
              child: Text("İptal",style: TextStyle(
              color: Color(0xffF00000),
              fontWeight: FontWeight.bold,
              ),),
              onPressed: (){
              Navigator.pop(context);
              },
              ),
              TextButton(
              child: Text("Mesaj Gönder",style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xffF00000),
              ),),
              onPressed: () async {
                SharedPreferences prefs1=await SharedPreferences.getInstance();
                no1= await prefs1.getString("phoneNumber1")??"";
                no2=await prefs1.getString("phoneNumber2")??"";
                if(no1=="" || no2==""){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Uyarı Mesajı !",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF00000),
                        ),),
                        content: Text("Acil durum numaralarını girmemiş veya eksik girmişsiniz. "
                            "Bu yüzden telefon kayıt sayfasına dönüp 2 numarayıda belirtilen şekilde giriniz .",style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mesajEkrani()));
                            },
                            child: Text("İptal",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF00000),
                            ),),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => telefonKayit(),));
                            },
                            child: Text("Telefon Kaydet",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF00000),
                            ),),
                          )
                        ],
                      );
                    },
                  );
                }
                else{
                  if(enlem==0.0 && boylam==0.0){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Konum hesaplanamamış veya izin verilmemiş"),
                        )
                    );
                    Navigator.pop(context);
                  }
                  else{
                    await telephony.sendSms(to: no1, message: "Bu Mesaj Deprem SOS uygulamasından gönderilmektedir.Güvendeyim,sakin olun !");
                    await telephony.sendSms(to: no1, message: "Şuanki konumum : https://www.google.com/maps?daddr=${enlem},${boylam}");
                    await telephony.sendSms(to: no2, message: "Bu Mesaj Deprem SOS uygulamasından gönderilmektedir.Güvendeyim,sakin olun !");
                    await telephony.sendSms(to: no2, message: "Şuanki konumum : https://www.google.com/maps?daddr=${enlem},${boylam}");
                    await  ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Mesaj Gönderildi"),
                        )
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Uyarı Mesajı",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF00000),
                            ),),
                            content: Text("Uygulamamıza göre mesajlar kaydedilen numaralara gönderilmiştir fakat gönderilip gönderilmediğini kontrol "
                                "etmeniz için uygulama kapatılacaktır.Kontrolden sonra tekrar dönebilirsiniz .",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            actions: [
                              TextButton(
                                onPressed: (){
                                  exit(0);
                                },
                                child: Text("Tamam",style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xffF00000),),),
                              ),
                            ],
                          );
                        }
                    );
                  }
                }
              },
              )
              ],
              );
              },
              );
              },
              child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      boxShadow:[
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0,10.0),
                          blurRadius: 10.0,
                        )
                      ],
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:[Color(0xff24FE41),Color(0xff24FE41)],
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 125,
                          height: 125,
                          child: Image.asset("iconlar/guven_icon.png")),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(deger_konum? "GPS Durumu : Konum Alındı !" : "GPS Durumu : Konum Alınıyor ...",style: TextStyle(
                    color: deger_konum? Color(0xff52c234) : Color(0xffF00000),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Enleminiz",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        Text("$enlem",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),)
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Boylamınız",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),),
                        Text("$boylam",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(()  {
            if(deger5==true){
              deger5=false;
            }
            else{
              deger5=true;
            }
          });
          if(deger5==false){
            await player.setAsset("assets/audios/durum_ses.mp3");
            player.play();
          }
          else{
            player.stop();
          }

        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("iconlar/ses_icons.png")
          ],
        ),
        elevation: 10,
        backgroundColor:deger5? Color(0xffF00000):Color(0xff414345),
      ),
    );
  }
}
