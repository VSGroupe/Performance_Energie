import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Body/header.dart';
import 'package:perf_energie/widgets/Composant/Form.dart';
import 'package:perf_energie/widgets/Consolides/InfoEnergetiques.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';

class GestionScreen extends StatefulWidget {
  const GestionScreen({super.key});

  @override
  State<GestionScreen> createState() => _GestionScreenState();
}

class _GestionScreenState extends State<GestionScreen> {
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
                  image: AssetImage(imgbackground),
                  fit:  BoxFit.cover
                  )
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Baniere(
                long: 1300,
                larg: 350,
                textsize1: 25,
                testsize2: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuTitle(
                          formtext:
                              "GESTION"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const MenuForm(
                            formtext:
                                "  GESTION DU SYSTEME DE MANAGEMENT DE L'ENERGIE (SME)  ",
                            long: 870,),
                          const SizedBox(height: 10),
            
                          ContenuSousMenu(
                            width: 870,
                            height: 300,
                            child: Row(
                                children: [
                                  const SizedBox(
                                    width: 430,
                                    child:  activitedoc1()),
                                    Container(
                                      height: 300,
                                      decoration: BoxDecoration(border: Border.all(color: Colors.black12, width: 1)),
                                    ),
                                    const SizedBox(
                                    width: 430,
                                    child:  activitedoc2()),
                                ],
                              ))
                              ,
                           ],
                       ),
                      const SizedBox(width: 20),
                    const Column(
                      children: [
                        MenuForm(formtext: "RESSOURCES",long: 870),
                        SizedBox(height: 10),
                        ContenuSousMenu(width:870, height:300, 
                        child: SizedBox(
                          width: 430,
                          child: Ressources())),
                      ],
                    ),
                    ],
                    ),
                  ),
              ) 
              ],
            )
          ],
        ),
    );
  }
}