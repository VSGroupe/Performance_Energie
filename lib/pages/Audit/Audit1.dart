import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Composant/Form.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';

class Audit1 extends StatefulWidget {
  const Audit1({super.key});

  @override
  State<Audit1> createState() => _Audit1State();
}

class _Audit1State extends State<Audit1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: secondColor,
          title: const InfoAppBar(),
        ),
      // UTILISATION DU DRAWER
      drawer: const Drawer(width: 300, child:SliderView (),),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgbackground), fit: BoxFit.cover))),
             const SingleChildScrollView(
              scrollDirection: Axis.vertical,
               child: Column(
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
                              "AUDIT DU SYSTEME DE MANAGEMENT DE L'ENERGIE - SME ",
                          textcolor: primaryColor,
                          color: Color.fromARGB(255, 196, 195, 195),
                        ),
                      ],
                    ),
                  ),
                ),
                 SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                       MenuForm(formtext: "RESULTATS DES AUDITS", long: 320,),
                       SizedBox(
                  height: 5,),
                        SizedBox(
                          width: 300,
                           height: 330,
                            child: Expanded(
                              child: listAdit()
                              )),
                    
                      ],
                    ),
                     SizedBox(
                  width: 100,),
                    Column(
                      children: [
                         MenuForm(formtext: "INTERPRETATION DES RESULTATS DE PERFORMANCE", long: 820,),
                          SizedBox(
                  height: 5,),
                        SizedBox(
                          width: 820,
                           height: 330,
                            child: dataResultat())
                      ],
                    ),
                  ],
                            ),
                ),
                         SizedBox(
                  height: 10,
                ),
                CopyRight(),
                         ],
                       ),
             ),
        ],
      ),
    );
  }
}
