import 'package:flutter/material.dart';
import 'package:perf_energie/pages/Profil/ProfilContenu.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:perf_energie/widgets/Body/header.dart';

class ProfilUser extends StatefulWidget {
  final int ongChange1 ;
  const ProfilUser({
    required this.ongChange1,
    super.key});

  @override
  State<ProfilUser> createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
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
                    text: 'Profil Utilisateurs',
                    icon: Icon(Icons.person_2_outlined),
                  ),
                  Tab(
                    text: "Mes notifications",
                    icon: Icon(Icons.notifications_on_rounded),
                  ),
                  Tab(
                    text: "Gestions des taches",
                    icon: Icon(Icons.work),
                  ),
                  Tab(
                    text: "Aides et assistances",
                    icon: Icon(Icons.support_agent_rounded),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ProfilContenu1('Profil des gestionnaires', ongChange: widget.ongChange1,),
                    ProfilContenu2("Mes notifications",ongchange: widget.ongChange1),
                    ProfilContenu3("Gestions des taches",ongchange: widget.ongChange1),
                    ProfilContenu4("Aides et assistances",ongchange: widget.ongChange1),
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
