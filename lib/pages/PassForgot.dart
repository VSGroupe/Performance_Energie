import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PassForgot extends StatefulWidget {
  const PassForgot({super.key});

  @override
  State<PassForgot> createState() => _PassForgotState();
}

class _PassForgotState extends State<PassForgot> {
  final supabase = Supabase.instance.client;

  bool _obsureText = true;
  bool _obsureTextNew = true;
  bool isLoadedPage = false;

  late final TextEditingController _newPassWord;
  late final TextEditingController _confirmPassWord;
  final _formKey = GlobalKey<FormState>();
  final RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
  String? t = "";

  void changePassWord(BuildContext context) async {
    setState(() {
      isLoadedPage = true;
    });

    try {
      String? email = supabase.auth.currentSession?.user.email;
      if (email != null) {
        await supabase.auth.updateUser(UserAttributes(
          email: email,
          password: _confirmPassWord.text.trim(),
        ));
        await Future.delayed(const Duration(milliseconds: 15));
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Succès",
            "Votre mot de passe a été modifié avec succès. $email", Colors.green));
        context.go("/account/login");
        setState(() {
          isLoadedPage = false;
        });
      } else {
        //await Future.delayed(const Duration(seconds: 1));
        setState(() {
          isLoadedPage = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
            "Echec", "La mise à jour du mot de passe a échoué.", Colors.red));
      }
} catch (e) {
      final message = e.toString().split("Exception: ").join("");
      //await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isLoadedPage = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  void initState() {
    setState(() {
      supabase.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;
        t = event.name;
        print('///////////////////////////$t/////////////////////////');
        print("///////////////////$session////////////////////////////");
      });
    });

    _newPassWord = TextEditingController();
    _confirmPassWord = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgbackground), fit: BoxFit.cover))),
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              if (width.round() > 700)
                Expanded(
                    child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Perfomance  ",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.orange,
                          ),
                        ),
                        Text("Energie",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontStyle: FontStyle.italic))
                      ],
                    ),
                    const SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Expanded(
                          child: Image.asset(
                        imglogin,
                        fit: BoxFit.fitWidth,
                      )),
                    )
                  ],
                )),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      SizedBox(
                        width: 500,
                        height: 740,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 30,
                          child: Column(children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Stack(children: [
                              Image.asset(imglogo,width: 150),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(140, 60, 0, 0),
                                child: Icon(Icons.lock_clock,
                                    color: errorColor, size: 40),
                              ),
                            ]),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              " RE-INITIALISATION",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: errorColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                                "voulez-vous modifier votre mot de passe ?",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black)),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(40),
                              child: SizedBox(
                                  child: Form(
                                      autovalidateMode: AutovalidateMode.always,
                                      key: _formKey,
                                      child: Column(children: [
                                        TextFormField(
                                          decoration: InputDecoration(
                                            hintText:
                                                ("Veuillez entrer votre Email de récupération"),
                                            labelText:
                                                ("Email de récupération"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            suffixIcon: const Icon(Icons.email),
                                          ),
                                        ),
                                        const SizedBox(height: 25),
                                        TextFormField(
                                          obscureText: _obsureText,
                                          decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obsureText = !_obsureText;
                                                });
                                              },
                                              child: Icon(_obsureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                            hintText: ("Exemple : Person@1234"),
                                            labelText: ("Votre nouveau passe"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          controller: _newPassWord,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                !regex.hasMatch(value)) {
                                              return 'Votre mot de passe doit contenir des caractères spéciaux.';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 25),
                                        TextFormField(
                                          obscureText: _obsureTextNew,
                                          decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obsureTextNew =
                                                      !_obsureTextNew;
                                                });
                                              },
                                              child: Icon(_obsureTextNew
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                            hintText:
                                                ("Veuillez confirmer votre mot de passe"),
                                            labelText:
                                                ("Confirmer Votre passe"),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          controller: _confirmPassWord,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Ce champ est vide.";
                                            }
                                            if (value != _newPassWord.text ||
                                                !regex.hasMatch(value)) {
                                              return "Vos mots de passe renseignés ne sont pas identiques.";
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 40),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: isLoadedPage
                                                ? null
                                                : () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      changePassWord(context);
                                                    }
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: errorColor,
                                              side: const BorderSide(
                                                color: Colors.blueGrey,
                                                width: 1,
                                              ),
                                              shape: const StadiumBorder(),
                                            ),
                                            child: isLoadedPage
                                                ? const SpinKitWave(
                                                    color: errorColor,
                                                    size: 30.0,
                                                  )
                                                : const Text(
                                                    "Confirmer la modification",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.grey),
                                            onPressed: () {
                                              context.go("/account/login");
                                            },
                                            child: const Text(
                                              "Retour à la connexion",
                                              style:
                                              TextStyle(fontSize: 18,
                                              color: errorColor),
                                            ))
                                      ]))),
                            ),
                          ]),
                        ),
                      ),
                    ]),
              )
            ],
          ),
          const CopyRight()
        ])
      ],
    ));
  }
}
