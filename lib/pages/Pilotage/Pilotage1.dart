

import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Consolides/InfoEnergetiques.dart';
import 'package:perf_energie/widgets/Composant/Form.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';


class Pilotage1 extends StatefulWidget {
  const Pilotage1({super.key});

  @override
  State<Pilotage1> createState() => _Pilotage1State();
}

class _Pilotage1State extends State<Pilotage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: secondColor,
          title: const InfoAppBar(),
          automaticallyImplyLeading: false,
        ),
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgbackground), fit: BoxFit.cover))),

      const Padding(
        padding: EdgeInsets.fromLTRB(10,0,10,0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Baniere(),
           
              MenuTitle(formtext: "PERFOMANCE ENERGETIQUE"),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        MenuForm(formtext: "CONSOLIDES", color: primaryColor,long: 300),
                        SizedBox(height: 10),
                        ContenuSousMenu(width:300, height:200, color: primaryColor, 
                        child: Consolides()),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        MenuForm(formtext: "AUTRES PERIMETRES",color: tertiaireColor,long: 300),
                        SizedBox(height: 10),
                        ContenuSousMenu(width:300, height:200, color: tertiaireColor,
                        child: AutrePerim()),
                    
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        MenuForm(formtext: "USINES", color: secondColor,long: 300),
                        SizedBox(height: 10),
                        ContenuSousMenu(width:300, height:200, color: secondColor, 
                        child: Usines()),
                      ],
                    ),
                  ],),
                  ),
      
          CopyRight()],),
      )
      ],), 
    );
  }
}



