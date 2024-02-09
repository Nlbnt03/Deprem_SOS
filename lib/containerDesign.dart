import 'package:flutter/material.dart';

class containerDesign extends StatefulWidget {
  String baslik;
  String icon_adres;
  bool deger;


  containerDesign(this.baslik, this.icon_adres, this.deger);

  @override
  State<containerDesign> createState() => _containerDesignState();
}

class _containerDesignState extends State<containerDesign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
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