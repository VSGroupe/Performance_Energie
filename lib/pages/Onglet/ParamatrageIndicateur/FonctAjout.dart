// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// CREATION DES AXES //////////////////////////////////////////////////////////////////////////////////////////

class Axeajout extends StatefulWidget {
  const Axeajout({super.key});

  @override
  _AxeajoutState createState() => _AxeajoutState();
}

class _AxeajoutState extends State<Axeajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final refController = TextEditingController();

  Future<void> _CreateData(BuildContext context) async {
    final refaxe = refController.text;
    final nomaxe = nomController.text;

    final response = await Supabase.instance.client.from('axe').insert({
      'ref_axe': refaxe,
      'nom_axe': nomaxe,
    });

    if (response == null) {
      const message = "L'axe a été enregistré avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de l'envoi des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop(); // Ferme automatiquement la fenêtre de dialogue
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 500,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Ajout d'un nouvel axe",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: axeColor)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la reference de l'axe";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Reférence de l'axe",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le nom de l'axe";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Définition de l'axe",
                  controller: nomController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      () async {
                        if (_formKey.currentState!.validate()) {
                          await _CreateData(
                              context); // Correction : await pour attendre la fin de l'exécution de la fonction
                        }
                      }(); // Correction : Appel de la fonction anonyme ici
                    },
                    child: const Text('Enregistrer',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CREATION DES ENJEUX //////////////////////////////////////////////////////////////////////////////////////////

class Enjeuajout extends StatefulWidget {
  const Enjeuajout({super.key});

  @override
  _EnjeuajoutState createState() => _EnjeuajoutState();
}

class _EnjeuajoutState extends State<Enjeuajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final refController = TextEditingController();
  List<dynamic> idAxes = [];
  late int idaxeValeur;

  Future<List> fetchidAxe() async {
    final response =
        await Supabase.instance.client.from('axe').select('id_axe,ref_axe');
    List<dynamic> ids = response.map((axe) => axe['id_axe']).toList();
    return ids;
  }

  dynamic retrouverValeur(dynamic selectedValue) async {
    int index = globalAxes.indexOf(selectedValue);
    if (index != -1 && index < idAxes.length) {
      print(globalAxes);
      print(idAxes);
      idaxeValeur = idAxes[index];
      print("son identifiant est : $idaxeValeur");
      return idaxeValeur;
    } else {
      print(globalAxes);
      print(idAxes);
      print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }


  Future<void> _CreateData(BuildContext context) async {
    final refenjeu = refController.text;
    final nomenjeu = nomController.text;

    final response = await Supabase.instance.client.from('enjeu').insert({
      'ref_enjeu': refenjeu,
      'nom_enjeu': nomenjeu,
      'id_axe': idaxeValeur,
    });

    if (response == null) {
      const message = "L'enjeu a été enregistré avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
      
    } else {
      const message = "Erreur lors de l'envoi des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop(); // Ferme automatiquement la fenêtre de dialogue
  }

  @override
  Widget build(BuildContext context) {
    fetchidAxe().then((ids) {
      idAxes = ids;
    }).catchError((error) {});
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 500,
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Ajout d'un nouvel enjeu",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: enjeuColor)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la reference de l'enjeu";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Reférence de l'enjeu",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le nom de l'enjeu";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Définition de l'enjeu",
                  controller: nomController,
                ),
                const SizedBox(height: 20),
                ComboPara(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez selectionner la réference de son axe";
                    }
                    return null;
                  },
                    listValeur: globalAxes,
                    labeltext: "Selection de l'axe",
                    onChanged: (dynamic selectedValue) {
                     retrouverValeur(selectedValue);
                    }),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      () async {
                        if (_formKey.currentState!.validate()) {
                          await _CreateData(context); // Correction : await pour attendre la fin de l'exécution de la fonction
                        }
                      }(); // Correction : Appel de la fonction anonyme ici
                    },
                    child: const Text('Enregistrer',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CREATION DES PROCESSUS //////////////////////////////////////////////////////////////////////////////////////////

class Processusajout extends StatefulWidget {
  const Processusajout({super.key});

  @override
  _ProcessusajoutState createState() => _ProcessusajoutState();
}

class _ProcessusajoutState extends State<Processusajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final refController = TextEditingController();
  List<dynamic> idEnjeux = [];
  late int idenjeuValeur;


  Future<List> fetchidEnjeux() async {
    final response =
        await Supabase.instance.client.from('enjeu').select('id_enjeu,ref_enjeu');
    List<dynamic> ids = response.map((enjeu) => enjeu['id_enjeu']).toList();
    return ids;
  }

  dynamic retrouverValeur(dynamic selectedValue) async {
    int index = globalEnjeux.indexOf(selectedValue);
    if (index != -1 && index < idEnjeux.length) {
      print(globalEnjeux);
      print(idEnjeux);
      idenjeuValeur = idEnjeux[index];
      print("son identifiant est : $idenjeuValeur");
      return idenjeuValeur;
    } else {
      // print(globalEnjeux);
      // print(idEnjeux);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

   Future<void> _CreateData(BuildContext context) async {
    final refprocess = refController.text;
    final nomprocess = nomController.text;

    final response = await Supabase.instance.client.from('processus').insert({
      'ref_process': refprocess,
      'nom_process': nomprocess,
      'id_enjeu': idenjeuValeur,
    });

    if (response == null) {
      const message = "Le processus a été enregistré avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
      
    } else {
      const message = "Erreur lors de l'envoi des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    fetchidEnjeux().then((ids) {
      idEnjeux = ids;
    }).catchError((error) {});
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 500,
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Ajout d'un nouveau processus",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: processusColor)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la reference du processus";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Reférence du processus",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le nom du processus";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Définition du processus",
                  controller: nomController,
                ),
                const SizedBox(height: 20),
                ComboPara(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez selectionner la réference de son enjeu";
                    }
                    return null;
                  },
                    listValeur: globalEnjeux,
                    labeltext: "Selection de l'enjeu",
                    onChanged: (dynamic selectedValue) {
                      retrouverValeur(selectedValue);
                    }),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      () async {
                        if (_formKey.currentState!.validate()) {
                          await _CreateData(context); // Correction : await pour attendre la fin de l'exécution de la fonction
                        }
                      }(); // Correction : Appel de la fonction anonyme ici
                    },
                    child: const Text('Enregistrer',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// CREATION DES CRITERES //////////////////////////////////////////////////////////////////////////////////////////

class Critereajout extends StatefulWidget {
  const Critereajout({super.key});

  @override
  _CritereajoutState createState() => _CritereajoutState();
}

class _CritereajoutState extends State<Critereajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final refController = TextEditingController();
  List<dynamic> idEnjeux = [];
  late int idenjeuValeur;


  Future<List> fetchidEnjeux() async {
    final response =
        await Supabase.instance.client.from('enjeu').select('id_enjeu,ref_enjeu');
    List<dynamic> ids = response.map((enjeu) => enjeu['id_enjeu']).toList();
    return ids;
  }

  dynamic retrouverValeur(dynamic selectedValue) async {
    int index = globalEnjeux.indexOf(selectedValue);
    if (index != -1 && index < idEnjeux.length) {
      print(globalEnjeux);
      print(idEnjeux);
      idenjeuValeur = idEnjeux[index];
      print("son identifiant est : $idenjeuValeur");
      return idenjeuValeur;
    } else {
      // print(globalEnjeux);
      // print(idEnjeux);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

   Future<void> _CreateData(BuildContext context) async {
    final refcritere = refController.text;
    final nomcritere = nomController.text;

    final response = await Supabase.instance.client.from('critere').insert({
      'ref_critere': refcritere,
      'nom_critere': nomcritere,
      'id_enjeu': idenjeuValeur,
    });

    if (response == null) {
      const message = "Le critère a été enregistré avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
      
    } else {
      const message = "Erreur lors de l'envoi des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    fetchidEnjeux().then((ids) {
      idEnjeux = ids;
    }).catchError((error) {});
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 500,
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Ajout d'un nouveau critère",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: critereColor)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la reference du critère";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Reférence du critère",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le nom du critère";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Définition du critère",
                  controller: nomController,
                ),
                const SizedBox(height: 20),
                ComboPara(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez selectionner la réference de son enjeu";
                    }
                    return null;
                  },
                    listValeur: globalEnjeux,
                    labeltext: "Selection de l'enjeu",
                    onChanged: (dynamic selectedValue) {
                      retrouverValeur(selectedValue);
                    }),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      () async {
                        if (_formKey.currentState!.validate()) {
                          await _CreateData(context); // Correction : await pour attendre la fin de l'exécution de la fonction
                        }
                      }(); // Correction : Appel de la fonction anonyme ici
                    },
                    child: const Text('Enregistrer',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// AUTRES ENREGISTREMENTS //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// CREATION DES TERMINOLOGIE ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Terminoajout extends StatefulWidget {
  const Terminoajout({super.key});

  @override
  _TerminoajoutState createState() => _TerminoajoutState();
}

class _TerminoajoutState extends State<Terminoajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final refController = TextEditingController();

  Future<void> _CreateData(BuildContext context) async {
    final reftermino = refController.text;
    final nomtermino = nomController.text;

    final response = await Supabase.instance.client.from('terminologie').insert({
      'ref_termino': reftermino,
      'nom_termino': nomtermino,
    });

    if (response == null) {
      const message = "La Terminologie a été enregistrée avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de l'envoi des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop(); // Ferme automatiquement la fenêtre de dialogue
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 500,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Ajout d'un nouvelle terminologie",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la reference de le terminologie";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Reférence de la terminologie",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le nom de la terminologie";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Définition de la terminologie",
                  controller: nomController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      () async {
                        if (_formKey.currentState!.validate()) {
                          await _CreateData(
                              context); // Correction : await pour attendre la fin de l'exécution de la fonction
                        }
                      }(); // Correction : Appel de la fonction anonyme ici
                    },
                    child: const Text('Enregistrer',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// AUTRES ENREGISTREMENTS //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// CREATION DES UNITES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Uniteajout extends StatefulWidget {
  const Uniteajout({super.key});

  @override
  _UniteajoutState createState() => _UniteajoutState();
}

class _UniteajoutState extends State<Uniteajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final refController = TextEditingController();

  Future<void> _CreateData(BuildContext context) async {
    final refunite = refController.text;
    final nomunite = nomController.text;

    final response = await Supabase.instance.client.from('unite').insert({
      'ref_unite': refunite,
      'abr_unite': nomunite,
    });

    if (response == null) {
      const message = "L'unité a été enregistrée avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de l'envoi des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop(); // Ferme automatiquement la fenêtre de dialogue
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 500,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Ajout d'une nouvelle unité",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la référence de l'unité";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Référence de l'unité",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir l'abréviation de l'unite";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Abréviation de l'unité",
                  controller: nomController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      () async {
                        if (_formKey.currentState!.validate()) {
                          await _CreateData(
                              context); // Correction : await pour attendre la fin de l'exécution de la fonction
                        }
                      }(); // Correction : Appel de la fonction anonyme ici
                    },
                    child: const Text('Enregistrer',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// AUTRES ENREGISTREMENTS //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// CREATION DES TYPES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Typeajout extends StatefulWidget {
  const Typeajout({super.key});

  @override
  _TypeajoutState createState() => _TypeajoutState();
}

class _TypeajoutState extends State<Typeajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final refController = TextEditingController();

  Future<void> _CreateData(BuildContext context) async {
    final reftype = refController.text;
    final nomtype = nomController.text;

    final response = await Supabase.instance.client.from('type').insert({
      'ref_type': reftype,
      'nom_type': nomtype,
    });

    if (response == null) {
      const message = "La réference du type a été enregistré avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de l'envoi des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop(); // Ferme automatiquement la fenêtre de dialogue
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 500,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Ajout d'un nouveau type de calcul",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la reference du type";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Reférence du type de calcul",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la définition de type de calcul";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Définition du type de calcul",
                  controller: nomController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      () async {
                        if (_formKey.currentState!.validate()) {
                          await _CreateData(
                              context); // Correction : await pour attendre la fin de l'exécution de la fonction
                        }
                      }(); // Correction : Appel de la fonction anonyme ici
                    },
                    child: const Text('Enregistrer',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// AUTRES ENREGISTREMENTS //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// CREATION DES FORMULES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Formuleajout extends StatefulWidget {
  const Formuleajout({super.key});

  @override
  _FormuleajoutState createState() => _FormuleajoutState();
}

class _FormuleajoutState extends State<Formuleajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final refController = TextEditingController();

  Future<void> _CreateData(BuildContext context) async {
    final refformule = refController.text;
    final opformule = nomController.text;

    final response = await Supabase.instance.client.from('formule').insert({
      'ref_formule': refformule,
      'operation': opformule,
    });

    if (response == null) {
      const message = "La formule a été enregistrée avec succès";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Succès", message, Colors.green));
    } else {
      const message = "Erreur lors de l'envoi des données";
      await Future.delayed(const Duration(milliseconds: 15));
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar("Echec", message, Colors.red));
    }
    Navigator.of(context).pop(); // Ferme automatiquement la fenêtre de dialogue
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 500,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Ajout d'une nouvelle formule",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la référence de la formule";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Référence de la formule",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir l'opération resultant de la formule ";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Opération de sortie de la formule",
                  controller: nomController,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      () async {
                        if (_formKey.currentState!.validate()) {
                          await _CreateData(
                              context); // Correction : await pour attendre la fin de l'exécution de la fonction
                        }
                      }(); // Correction : Appel de la fonction anonyme ici
                    },
                    child: const Text('Enregistrer',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler',
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
