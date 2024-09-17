import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:perf_energie/widgets/Body/InfoBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final supabase = Supabase.instance.client;
  final storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  bool isLoadedPage = false;
  bool _obsureText = true;
  String? session = "B";
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');

  void login(BuildContext context) async {
    setState(() {
      isLoadedPage = true;
    });
    try {
      final result = await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final email = result.user?.email;
      final accesToken = result.session?.accessToken;

      if (email != null && accesToken != null) {
        await storage.write(key: 'logged', value: "true");
        await storage.write(key: 'email', value: email);
        await Future.delayed(const Duration(milliseconds: 15));
        context.go("/");

        setState(() {
          isLoadedPage = false;
        });
      } else {
        const message = "Vos identifiants sont incorrectes";
        await Future.delayed(const Duration(milliseconds: 15));
        setState(() {
          isLoadedPage = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(showSnackBar("Echec", message, Colors.red));
      }
    } on Exception catch (e) {
      print(e.toString());
      const message = "Vos identifiants sont incorrectes";
      await Future.delayed(const Duration(milliseconds: 15));
      setState(() {
        isLoadedPage = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;

      setState(() {
        session = event.name;
      });
      // if (session == "passwordRecovery") {
      //   // context.go("/account/change-password",extra:"passowrdRecovery");
      // }
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
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
                    Image.asset(
                        imglogin,
                        fit: BoxFit.fitWidth,
                      )
                  ],
                )),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                          height: 800,
                          width: 500,
                          child: Card(
                            elevation: 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Column(children: [
                              const SizedBox(
                                height: 80,
                              ),
                              Stack(children: [
                                Image.asset(
                                  imglogo,
                                  width: 150,
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(140, 60, 0, 0),
                                ),
                              ]),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "IDENTIFICATION",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                  "Utilisez le compte ci-dessous pour vous connecter.",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.black)),
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.all(40),
                                child: SizedBox(
                                    child: Form(
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        key: _formKey,
                                        child: Column(children: [
                                          TextFormField(
                                            autofocus: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !GetUtils.isEmail(value)) {
                                                return 'Svp veuillez entrer un e-mail correct.';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText:
                                                  ("Veuillez entrer votre Email"),
                                              labelText: ("Votre Email"),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              suffixIcon:
                                                  const Icon(Icons.email),
                                            ),
                                            controller: _emailController,
                                          ),
                                          const SizedBox(height: 25),
                                          TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Svp veuillez entrer un mot de passe fonctionnel';
                                              }
                                              return null;
                                            },
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
                                              hintText:
                                                  ("Veuillez saisir votre mot de passe"),
                                              labelText: ("Votre mot de passe"),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            controller: _passwordController,
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
                                                        login(context);
                                                      }
                                                    },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                side: const BorderSide(
                                                  color: Colors.blueGrey,
                                                  width: 1,
                                                ),
                                                shape: const StadiumBorder(),
                                              ),
                                              child: isLoadedPage
                                                  ? const SpinKitWave(
                                                      color: Colors.blue,
                                                      size: 30.0,
                                                    )
                                                  : const Text(
                                                      "S'identifier",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ]))),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              TextButton(
                                onPressed: () {
                                  context.go('/account/forgot-password');
                                },
                                child: const Text("Mot de passe oublié ?",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red)),
                              )
                            ]),
                          ))
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
