import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/pages/Onglet/OngletPage.dart';
import 'package:perf_energie/widgets/Body/header.dart';

class ProfilPage extends StatefulWidget {
  final int ongChange1 ;
  const ProfilPage({
    required this.ongChange1,
    super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondColor,
        title: const InfoAppBar(),
      ),
      // UTILISATION DU DRAWER
      drawer: const Drawer(
        width: 300,
        child: SliderView(),
      ),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgbackground), fit: BoxFit.cover))),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
             const SizedBox(height: 20,),

              const TabBar(
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                labelColor: Color.fromARGB(255, 2, 104, 6),
                unselectedLabelColor: Colors.black,
                indicatorColor: Color.fromARGB(255, 2, 104, 6),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                dividerColor: Colors.transparent,
                tabs: <Widget>[
                  Tab(
                    text: 'Configuration panel utilisateur',
                    icon: Icon(Icons.person_2_outlined),
                  ),
                  Tab(
                    text: "Panneau Administration",
                    icon: Icon(Icons.settings_accessibility_outlined),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    NestedTabBar('Profil des gestionnaires', ongChange: widget.ongChange1,),
                    NestedTabBar2("Panneau d'Administration",ongchange: widget.ongChange1),
                  ],
                ),
              ),

              const CopyRight()
            ],
          )
        ],
      ),
    );
  }
}
