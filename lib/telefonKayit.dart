import 'package:deprem_uygulamasi/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class telefonKayit extends StatefulWidget {

  @override
  State<telefonKayit> createState() => _telefonKayitState();
}

class _telefonKayitState extends State<telefonKayit> {
  String no1="";
  String no2="";
  var formKey=GlobalKey<FormState>();
  var tfcontroller1=TextEditingController();
  var tfcontroller2=TextEditingController();
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
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration:BoxDecoration(
          boxShadow:[
          BoxShadow(
          color: Colors.black,
            offset: Offset(0.0,10.0),
            blurRadius: 10.0,
          )
        ],
          borderRadius: BorderRadius.circular(20.0),
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:[Color(0xffECE9E6),Color(0xffFFFFFF)],
          )
      ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Aşağıda sizden 2 adet acil durum numarası isteniyor.Bu numaralar acil durumda konumunuzun gönderileceği numaralardır."
                        "O yüzden doğru numara girmeye özen gösteriniz.Numaranın başına 0(sıfır) yazarak giriniz !",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("1.Telefon Numarası :",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        SizedBox(
                          height: 60,
                          width: 200,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: tfcontroller1,
                            decoration: InputDecoration(
                              hintText: "0 555 555 55 55",
                              filled: true,
                              fillColor: Color(0xffF7F8F8),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              )
                            ),
                            validator: (tfgirdisi){
                              if(tfgirdisi!.isEmpty){
                                return "Telefon Numarasını giriniz";
                              }
                              if(tfgirdisi!.length!=11){
                                return "Geçerli Telefon Numarası Giriniz";
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("2.Telefon Numarası :",style:TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: tfcontroller2,
                          decoration: InputDecoration(
                              hintText: "0 555 555 55 55",
                              filled: true,
                              fillColor: Color(0xffF7F8F8),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          ),
                          validator: (tfgirdisi){
                            if(tfgirdisi!.isEmpty){
                              return "Telefon Numarasını giriniz";
                            }
                            if(tfgirdisi!.length!=11){
                              return "Geçerli Telefon Numarası Giriniz";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffF00000),
                              shadowColor: Colors.black,
                              elevation: 10,
                            ),
                            child: Text("Kaydet",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),),
                            onPressed: () async{
                              bool kontrol_sonucu=formKey.currentState!.validate();
                              if(kontrol_sonucu){
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => mesajEkrani(tfcontroller1.text, tfcontroller2.text),));
                                SharedPreferences prefs= await SharedPreferences.getInstance();
                                no1=tfcontroller1.text;
                                no2=tfcontroller2.text;
                                await prefs.setString("phoneNumber1", no1);
                                await prefs.setString("phoneNumber2", no2);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Numaralar Kayıt Edildi")));
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffF00000),
                            shadowColor: Colors.black,
                            elevation: 10,
                          ),
                          onPressed: () async{
                            SharedPreferences prefs2=await SharedPreferences.getInstance();
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Uyarı Mesajı !",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffF00000),
                                  ),),
                                  content: Text("Sisteme kaydettiğiniz telefon numaralarını silmek istediğinize emin misiniz ?",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text("İptal",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffF00000),
                                      ),),
                                    ),
                                    TextButton(
                                      child: Text("Sil",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffF00000),
                                      ),),
                                      onPressed: (){
                                        prefs2.remove("phoneNumber1");
                                        prefs2.remove("phoneNumber2");
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Kayıtlı Numaralar Silindi"))
                                        );
                                      },
                                    )
                                  ],
                                );
                              }
                            );
                          },
                          child: Text("Verileri Sil"),
                        ),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () async{
                      SharedPreferences prefs2=await SharedPreferences.getInstance();
                      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("${prefs2.getString("phoneNumber1")??"Kayıtlı Numara Yok"}\t,\t${prefs2.getString("phoneNumber2")??"Kayıtlı Numara Yok"}")));
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Aktif Telefon Numaraları ",style: TextStyle(
                              color: Color(0xffF00000),
                              fontWeight: FontWeight.bold,
                            ),),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.person),
                                    Text("${prefs2.getString("phoneNumber1")??"Kayıtlı Numara Yok"}"),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.person),
                                    Text("${prefs2.getString("phoneNumber2")??"Kayıtlı Numara Yok"}"),
                                  ],
                              ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text("Tamam",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffF00000),
                                ),),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        }
                      );
                    },
                    child: Text("Aktif Telefon Numaraları ?",style: TextStyle(
                      color: Color(0xffF00000),
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
