import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/Audit/AuditPage.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Composant/Form.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({super.key});

  @override
  State<AcceuilPage> createState() => _AcceuilPageState();
}

class _AcceuilPageState extends State<AcceuilPage> {
  bool isHovered1 = false;
  bool isHovered2 = false;
  bool isHovered3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondColor,
        title: const InfoAppBar(),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Expanded(
            child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imgbackground), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              const Baniere(),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: InkWell(
                          onTap: () {
                            context.go("/gestion");
                          },
                          onHover: (value1) {
                            setState(() {
                              isHovered1 = value1;
                            });
                          },
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: BlockMenuAcc(
                              text1: "GESTION",
                              text2: "",
                              imgAcess: "assets/images/gestion.jpg",
                              shadow: secondColor,
                              elevation: isHovered1 ? 30 : 10,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: InkWell(
                          onTap: () {
                            OpenPage(context, const AuditPage());
                          },
                          onHover: (value1) {
                            setState(() {
                              isHovered1 = value1;
                            });
                          },
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: BlockMenuAcc(
                              text1: "AUDIT",
                              text2: "Analyse des différents données",
                              imgAcess: "assets/images/audit_main.png",
                              shadow: secondColor,
                              elevation: isHovered1 ? 30 : 10,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.go("/pilotage");
                        },
                        onHover: (value2) {
                          setState(() {
                            isHovered2 = value2;
                          });
                        },
                        child: SizedBox(
                            height: 300,
                            width: 300,
                            child: BlockMenuAcc(
                                text1: "PILOTAGE",
                                text2: "Observation des differents enjeux",
                                imgAcess: "assets/images/pilotage.png",
                                shadow: primaryColor,
                                elevation: isHovered2 ? 30 : 10)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: InkWell(
                          hoverColor: Colors.amber,
                          onTap: () {
                            OpenPage(context, const AuditPage());
                          },
                          onHover: (value3) {
                            setState(() {
                              isHovered3 = value3;
                            });
                          },
                          child: SizedBox(
                              height: 300,
                              width: 300,
                              child: BlockMenuAcc(
                                  text1: "RAPPORTS",
                                  text2: "Compte rendu des données",
                                  imgAcess: "assets/images/perf_rse.png",
                                  shadow: tertiaireColor,
                                  elevation: isHovered3 ? 30 : 10)),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        )),
        const CopyRight()
      ]),
    );
  }
}
