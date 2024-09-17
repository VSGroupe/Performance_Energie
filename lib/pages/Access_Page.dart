import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/AcceuilPage.dart';
import 'package:perf_energie/widgets/Composant/LoadingWidget.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccessPage extends StatefulWidget {
  const AccessPage({Key? key}) : super(key: key);

  @override
  State<AccessPage> createState() => _AccessPageState();
}

class _AccessPageState extends State<AccessPage> {
  final storage = const FlutterSecureStorage();
  final supabase = Supabase.instance.client;
  late Future<Map> mainData;

  @override
  void initState() {
    super.initState();
    mainData = loadDataMain();
  }

  Future<Map> loadDataMain() async {
    var data = {};
    String? email = await storage.read(key: 'email');
    print(email);
    try {
      final user = await supabase
          .from('contributeur')
          .select()
          .eq('email_contribut', email!);
      print(user);

      data["user"] = user![0];
      Provider.of<LoginName>(context, listen: false).updateData(data);
      return data;
    } catch (e) {
      print(e);
      return data;
    }
  }

//  Future<Map> loadDataMain () async{
//     var data = {};
//     String? email = await storage.read(key: 'email');
//     final contributeur = await supabase.from('contributeur').select().eq('email', email!);
//     data["Users"] = contributeur[0] ;
//     return data;
//   }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Accès refusé'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               const Text("Vous n'avez pas accès à cet espace."),
  //               const SizedBox(height: 20,),
  //               Image.asset("assets/images/forbidden.png",width: 50,height: 50,)
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<bool> checkAccesPilotage(String email) async {
  //   final result = await supabase.from("AccesPilotage").select().eq("email", email);
  //   final acces = result[0];
  //   if (acces["est_bloque"]) {
  //     _showMyDialog();
  //     return false;
  //   }
  //   if (acces["est_admin"]) {
  //     context.go("/pilotage");
  //     return true;
  //   }
  //   if (acces["est_spectateur"] || acces["est_editeur"] || acces["est_validateur"] || acces["est_admin"]) {
  //     context.go("/pilotage");
  //     return true;
  //   }
  //   _showMyDialog();
  //   return false;
  // }

  // Future<bool> checkAccesEvaluation(String email) async {
  //   context.go("/evaluation");
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: mainData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Erreur: ${snapshot.error}'),
              ),
            );
          }

          // Si le Future a réussi, récupérez les données et construisez votre widget
          // ignore: unused_local_variable
          final data = snapshot.data!;
          return const //DefaultTabController(
              //                         initialIndex: 1,
              //                          length: 2,
              //                         child: ProfilPage(ongChange1: 3));
              AcceuilPage();
        } else {
          // Gérer le chargement (peut-être afficher un indicateur de chargement)
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: LoadingWidget(),
            ),
          );
        }
      },
    );
  }
}
