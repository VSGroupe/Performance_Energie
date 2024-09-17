

import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';


// MODELE DU PIED DE PAGE (COPYRIGHT)::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


class CopyRight extends StatefulWidget {
  const CopyRight({super.key});

  @override
  State<CopyRight> createState() => _CopyRightState();
}

class _CopyRightState extends State<CopyRight> {
bool isConnected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.blueGrey
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30 ),
          child: InkWell(
            onTap: () {},
            child: const TextInfo(
                text: "Copyright @ Vision & Strategie Groupe",
                size: 15,
                weight: FontWeight.bold,
                color: Colors.white,
              ), 
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: RichText( 
              text: TextSpan(
                text: "Status : ",
                children: [
                  TextSpan(
                      text: isConnected
                          ? "Connecté"
                          : "Aucune connection internet",
                      style: TextStyle(
                          color: isConnected ? validelightColor : errorColor))
                ],
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}




