
import 'package:flutter/material.dart';

// ignore: camel_case_types
class listNotif extends StatefulWidget {
  const listNotif({super.key});

  @override
  State<listNotif> createState() => _listNotifState();
}

// ignore: camel_case_types
class _listNotifState extends State<listNotif> {
  final objet = [
    {
      "msg": "Message",
      "date": "13/04/2023",
      "obj":"Bonjour, l'entreprise vous sollicite de bien nous excuse pour les soucis avec l'application en raison de mise à jour. Cordialement VSGroupe",
    },
    {
      "msg": "Message",
      "date": "07/04/2023",
      "obj": "Bonjor, le groupe VSGroupe tient a vous remerciez personnellement pour la grande confiant que vous nous faites preuve. Cordialement VSGroupe",
    },
    {
      "msg": "Message",
      "date": "12/11/2022",
      "obj": "Bonjours, le Groupe VS vous felicite pour votre adhésion a sa plateforme de gestion RSE et Perfomance Energétique",
    },
    {
      "msg": "Message",
      "date": "30/03/ 2021",
      "obj": "Coup  du siècle, nous somme ravi de vous compter parmi nos clients les plus fidèles. Cordialement VS Groupe",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: objet.length,
        itemBuilder: (context, index) {
          final event = objet[index];
          final msg = event['msg'];
          final date = event['date'];
          final obj = event['obj'];
          return Card(
              elevation: 0,
              color: Colors.transparent,
              child: Column(
                children: [
                  Text(
                    "$msg du $date ",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,)
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    "$obj",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,),
                  ),
                  const SizedBox(height: 20,),
                  const Divider()

                ],
              ));
        });
  }
}