import 'package:flutter/material.dart';
import 'package:perf_energie/pages/Pilotage/Pilotage1.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Composant/Form.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';

class PilotagePage extends StatefulWidget {
  const PilotagePage({super.key});

  @override
  State<PilotagePage> createState() => _PilotagePageState();
}

class _PilotagePageState extends State<PilotagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: secondColor,
          title: const InfoAppBar(),
          automaticallyImplyLeading: false,
        ),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgbackground), fit: BoxFit.cover))),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          
              Baniere(
                long: 1300,
                larg: 350,
                textsize1: 25,
                testsize2: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuTitle(
                          formtext:
                              "ESPACE DE PILOTAGE DE LA PERFORMANCE ENERGETIQUE DU SME"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          MenuForm(
                              formtext:
                                  "  INDICATEURS DE PERFORMANCE ENERGETIQUE  "),
                          SizedBox(height: 10),

                          ContenuSousMenu(
                            child: Pilotage1()
                            ),

                         SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CopyRight()
            ],),
        ],
      ),
    );
  }
}
