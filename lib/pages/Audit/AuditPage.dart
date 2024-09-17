import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Composant/Form.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';

class AuditPage extends StatefulWidget {
  const AuditPage({super.key});

  @override
  State<AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage> {
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
         Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            const Baniere(
              long: 1300,
              larg: 350,
              textsize1: 25,
              testsize2: 20,
            ),
           const  SizedBox(
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
                            "ESPACE AUDIT DU SYSTEME DE MANAGEMENT DE L'ENERGIE - SME"),
                     ],
                ),
              ),
            ),
            const SizedBox(
                      height: 10,
                    ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      const MenuForm(
                        formtext: "AUDIT GENERAL",
                        long: 300,
                         color:Color.fromARGB(255, 204, 200, 200),
                         textcolor: primaryColor,
                      ),
                      const SizedBox(height: 10,),
                      Container(
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                  border:
                                      Border.all(color: primaryColor, width: 2)),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(0,5,0,5),
                                child: audit(),
                              )),
                    ],
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    children: [
                      const MenuForm(
                        formtext: "AUDIT ADMINISTRATION",
                        long: 300,
                         color:Color.fromARGB(255, 204, 200, 200),
                         textcolor: secondColor,
                      ),
                      const SizedBox(height: 10,),
                      Container(
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                  border:
                                      Border.all(color: secondColor, width: 2)),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(0,5,0,5),
                                child: audit(),
                              )),
                    ],
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    children: [
                      const MenuForm(
                        formtext: "AUDIT PRODUCTION D'ELECTRICITE",
                        long: 300,
                         color:Color.fromARGB(255, 204, 200, 200),
                         textcolor: secondColor,
                      ),
                      const SizedBox(height: 10,),
                      Container(
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                  border:
                                      Border.all(color: secondColor, width: 2)),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(0,5,0,5),
                                child: audit(),
                              )),
                    ],
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    children: [
                     const MenuForm(
                        formtext: "AUTRES",
                        long: 300,
                         color:Color.fromARGB(255, 204, 200, 200),
                         textcolor: secondColor,
                      ),
                      const SizedBox(height: 10,),
                      Container(
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                  border:
                                      Border.all(color: secondColor, width: 2)),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(0,5,0,5),
                                child: auditask(),
                              )),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonIcon(text: "CONSULTER LES RESULTATS DES AUDITS",
                width: 380,
                color: primaryColor, 
                icon: Icons.query_stats_outlined,
                iconcolor: primaryColor,
                tap: (){

                }),
                ],),
            const CopyRight()
          ],
               )
      ]),
    );
  }
}
