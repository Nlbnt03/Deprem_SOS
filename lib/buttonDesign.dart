import 'package:flutter/material.dart';

class buttonDesign extends StatefulWidget {
  String baslik;
  String icon_adres;
  bool deger;


  buttonDesign(this.baslik, this.icon_adres, this.deger);

  @override
  State<buttonDesign> createState() => _buttonDesignState();
}

class _buttonDesignState extends State<buttonDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            colors:widget.deger? [Color(0xffF00000),Color(0xffDC281E)]:[Color(0xff232526),Color(0xff414345)],
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(widget.icon_adres,)),
        ],
      ),
    );
  }
}
