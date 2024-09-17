import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


// AUTRES ENREGISTREMENTS //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// CREATION DES GROUPES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Groupajout extends StatefulWidget {
  const Groupajout({super.key});

  @override
  _GroupajoutState createState() => _GroupajoutState();
}

class _GroupajoutState extends State<Groupajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();

  Future<void> _CreateData(BuildContext context) async {
    final nomgroup = nomController.text;
    final emailgroup = emailController.text;
    final contactgroup = contactController.text;

    final response = await Supabase.instance.client.from('group').insert({
      'nom_group': nomgroup,
      'email_group': emailgroup,
      'contact_group': contactgroup,
    });

    if (response == null) {
      const message = "Le Groupe a été enregistré avec succès";
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
                const Text("Ajout d'un nouveau groupe",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le nom du groupe";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Nom du groupe",
                  controller: nomController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le Email du groupe";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Email du groupe",
                  controller: emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le contact du groupe";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Contact du groupe",
                  controller: contactController,
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

// CREATION DES FILIERES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Filereajout extends StatefulWidget {
  const Filereajout({super.key});

  @override
  _FilereajoutState createState() => _FilereajoutState();
}

class _FilereajoutState extends State<Filereajout> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  List<dynamic> idGroup = [];
  late int idgroupValeur;

  Future<List> fetchidGroup() async {
    final response =
        await Supabase.instance.client.from('group').select('id_group,nom_group');
    List<dynamic> ids = response.map((group) => group['id_group']).toList();
    return ids;
  }

   dynamic retrouverValeur(dynamic selectedValue) async {
    int index = globalgroup.indexOf(selectedValue);
    if (index != -1 && index < idGroup.length) {
      print(" toi la $globalgroup");
      print(idGroup);
      idgroupValeur = idGroup[index];
      print("son identifiant est : $idgroupValeur");
      return idgroupValeur;
    } else {
      print(globalgroup);
      print(idGroup);
      print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _CreateData(BuildContext context) async {
    final nomfiliere = nomController.text;

    final response = await Supabase.instance.client.from('filiere').insert({
      'nom_filiere': nomfiliere,
      'id_group': idgroupValeur,
    });

    if (response == null) {
      const message = "La filière a été enregistrée avec succès";
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
fetchidGroup().then((ids) {
      idGroup = ids;
    }).catchError((error) {});

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
                const Text("Ajout d'une nouvelle filière",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le nom de la filière";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Nom de la filière",
                  controller: nomController,
                ),const SizedBox(height: 20),
                ComboPara(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez sélectionner le groupe";
                    }
                    return null;
                  },
                    listValeur: globalgroup,
                    labeltext: "Selection du groupe",
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

// CREATION DES PAYS ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Paysajout extends StatefulWidget {
  const Paysajout({super.key});

  @override
  _PaysajoutState createState() => _PaysajoutState();
}

class _PaysajoutState extends State<Paysajout> {
  final _formKey = GlobalKey<FormState>();
  final refController = TextEditingController();
  final idenController = TextEditingController();


  Future<void> _CreateData(BuildContext context) async {
    final refpays = refController.text;
    final idenpays = idenController.text;

    final response = await Supabase.instance.client.from('pays').insert({
      'ref_pays': refpays,
      'identification': idenpays,
    });

    if (response == null) {
      const message = "Le pays a été enregistré avec succès";
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
                const Text("Ajout d'un nouveau pays",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir le nom du pays";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Nom du pays",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textfieldIcon(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir l'identifiant du pays'";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "N° d'identification du pays",
                  controller: idenController,
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

// CREATION DES VILLES ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Villeajout extends StatefulWidget {
  const Villeajout({super.key});

  @override
  _VilleajoutState createState() => _VilleajoutState();
}

class _VilleajoutState extends State<Villeajout> {
  final _formKey = GlobalKey<FormState>();
  final refController = TextEditingController();
     List<dynamic> idPays = [];
  late int idpaysValeur;

  Future<List> fetchidPays() async {
    final response =
        await Supabase.instance.client.from('pays').select('id_pays,ref_pays');
    List<dynamic> ids = response.map((pays) => pays['id_pays']).toList();
    return ids;
  }

   dynamic retrouverValeur(dynamic selectedValue) async {
    int index = globalpays.indexOf(selectedValue);
    if (index != -1 && index < idPays.length) {
      print(globalpays);
      print(idPays);
      idpaysValeur = idPays[index];
      print("son identifiant est : $idpaysValeur");
      return idpaysValeur;
    } else {
      print(globalpays);
      print(idPays);
      print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }


  Future<void> _CreateData(BuildContext context) async {
    final refville = refController.text;

    final response = await Supabase.instance.client.from('ville').insert({
      'ref_ville': refville,
      'id_pays': idpaysValeur,
                
    });

    if (response == null) {
      const message = "La ville a été enregistrée avec succès";
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
    fetchidPays().then((ids) {
      idPays = ids;
    }).catchError((error) {});

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
                const Text("Ajout d'une nouvelle ville",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
                const SizedBox(
                  height: 30,
                ),
                textfieldIcon(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez saisir la référence de la ville";
                    }
                    return null;
                  },
                  hintText: "",
                  label: "Nom de la ville",
                  controller: refController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ComboPara(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Svp veuillez selectionner le pays";
                    }
                    return null;
                  },
                    listValeur: globalpays,
                    labeltext: "Selection du pays",
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
