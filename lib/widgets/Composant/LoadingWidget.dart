import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
     Image.asset("assets/gifs/Loading.gif"
        ,width: 800,height: 600,)));
  }
} 