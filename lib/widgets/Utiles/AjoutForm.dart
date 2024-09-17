import 'package:flutter/material.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/widgets/Composant/Button.dart';
import 'package:perf_energie/widgets/Composant/Help.dart';
import 'package:perf_energie/widgets/Composant/TextCall.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//  FONCTION DE REMPLISSAGES DE LA LISTE DES COMBOS  ///////////////////////////////////////////////////////////////////////////////////////////////////////


Future<int> mettreAJourTextController() async {

  final response = await Supabase.instance.client
      .from('indicateur')
      .select('num_indic').order('num_indic', ascending: false).limit(1); 
  try {
    int derniereValeur = response[0]['num_indic'] as int;
    int nouvelleValeur = derniereValeur + 1;
    print("La nouvelle valeur est $nouvelleValeur");
    return nouvelleValeur;
  } catch (error) {
    print('Erreur lors de la récupération de la dernière valeur: $error');
    // Gérer l'erreur en conséquence
    rethrow; // Pour relancer l'erreur
  }
}

Future<List> fetchProcessus() async {
  final response = await Supabase.instance.client.from('processus').select();
  List<dynamic> refs =
      response.map((process) => process['nom_process']).toList();
  return refs;
}

Future<List> fetchCritere() async {
  final response = await Supabase.instance.client.from('critere').select();
  List<dynamic> refs =
      response.map((critere) => critere['nom_critere']).toList();
  return refs;
}

Future<List> fetchTermino() async {
  final response = await Supabase.instance.client.from('terminologie').select();
  List<dynamic> refs =
      response.map((termino) => termino['nom_termino']).toList();
  return refs;
}

Future<List> fetchUnite() async {
  final response = await Supabase.instance.client.from('unite').select();
  List<dynamic> refs = response.map((axe) => axe['ref_unite']).toList();
  return refs;
}

Future<List> fetchType() async {
  final response = await Supabase.instance.client.from('type').select();
  List<dynamic> refs = response.map((enjeu) => enjeu['ref_type']).toList();
  return refs;
}

Future<List> fetchRole() async {
  final response = await Supabase.instance.client.from('role').select();
  List<dynamic> refs = response.map((role) => role['ref_role']).toList();
  return refs;
}

Future<List> fetchEntite() async {
  final response = await Supabase.instance.client.from('entite').select();
  List<dynamic> refs = response.map((entite) => entite['nom_entite']).toList();
  return refs;
}

Future<List> fetchFiliere() async {
  final response = await Supabase.instance.client.from('filiere').select();
  List<dynamic> refs =
      response.map((filiere) => filiere['nom_filiere']).toList();
  return refs;
}

Future<List> fetchFiliale() async {
  final response = await Supabase.instance.client.from('filiale').select();
  List<dynamic> refs =
      response.map((filiale) => filiale['nom_filiale']).toList();
  return refs;
}

Future<List> fetchVille() async {
  final response = await Supabase.instance.client.from('ville').select();
  List<dynamic> refs = response.map((ville) => ville['ref_ville']).toList();
  return refs;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMULAIRE D'AJOUT DES CONTRIBUTEURS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class AjoutContributeur extends StatefulWidget {
  const AjoutContributeur({super.key});

  @override
  State<AjoutContributeur> createState() => _AjoutContributeurState();
}

class _AjoutContributeurState extends State<AjoutContributeur> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final adresseController = TextEditingController();
  final fonctionController = TextEditingController();
  Set<List<dynamic>> idsRec = {};
  List<dynamic> idRole = [];
  List<dynamic> idEntite = [];
  List<dynamic> idProcess = [];
  late int idRoleValeur;
  late int idEntiteValeur;
  late int idProcessValeur;
  late String civiliteValeur;
  bool isAudit = false;
  bool isPilotage = false;
  bool isRapport = false;
  String? image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = pickedImage.path;
        print(image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Set<List>> fetchidCombo() async {
    final response1 =
        await Supabase.instance.client.from('role').select('id_role');
    List<dynamic> idsRole = response1.map((role) => role['id_role']).toList();

    final response2 =
        await Supabase.instance.client.from('entite').select('id_entite');
    List<dynamic> idsEntite =
        response2.map((entite) => entite['id_entite']).toList();

    final response3 =
        await Supabase.instance.client.from('processus').select('id_process');
    List<dynamic> idsProcess =
        response3.map((process) => process['id_process']).toList();

    return {idsRole, idsEntite, idsProcess};
  }

  Future<void> getData() async {
    Set<List> comboData = await fetchidCombo();
    List<dynamic> idsRole = comboData.elementAt(0);
    List<dynamic> idsEntite = comboData.elementAt(1);
    List<dynamic> idsProcess = comboData.elementAt(2);
    idRole = idsRole;
    idEntite = idsEntite;
    idProcess = idsProcess;

    print("Role est $idRole"); // Cela imprime les idsRole récupérés
    print("Entite est $idEntite"); // Cela imprime les idsEntite récupérés
    print("Processus est $idProcess"); // Cela imprime les idsProcess récupérés
  }

  @override
  void initState() {
    super.initState();
    getData(); // Appel de getData() lorsque le widget est créé
  }

  dynamic retrouverRole(dynamic selectedValue) async {
    int index = globalRole.indexOf(selectedValue);
    if (index != -1 && index < idRole.length) {
      //print(globalProcessus);
      //print(idProcess);
      idRoleValeur = idRole[index];
      print("son identifiant est : $idRoleValeur");
      return idRoleValeur;
    } else {
      // print(globalProcessus);
      // print(idProcess);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverEntite(dynamic selectedValue) async {
    int index = globalentite.indexOf(selectedValue);
    if (index != -1 && index < idEntite.length) {
      //print(globalUnite);
      //print(idUnite);
      idEntiteValeur = idEntite[index];
      print("son identifiant est : $idEntiteValeur");
      return idEntiteValeur;
    } else {
      // print(globaluniteus);
      // print(idunite);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverProcess(dynamic selectedValue) async {
    int index = globalProcessus.indexOf(selectedValue);
    if (index != -1 && index < idProcess.length) {
      //print(globalUnite);
      //print(idUnite);
      idProcessValeur = idProcess[index];
      print("son identifiant est : $idProcessValeur");
      return idProcessValeur;
    } else {
      // print(globaluniteus);
      // print(idunite);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _CreateData(BuildContext context) async {
    final nom = nomController.text;
    final prenom = prenomController.text;
    final email = emailController.text;
    final contact = contactController.text;
    final adresse = adresseController.text;
    final fonction = fonctionController.text;

    try {
      final response =
          await Supabase.instance.client.from('contributeur').insert({
        'nom_contribut': nom,
        'prenom_contribut': prenom,
        'email_contribut': email,
        'contact_contribut': contact,
        'adresse_contribut': adresse,
        'fonction_contribut': fonction,
        'photo_contribut': image,
        'civilite': civiliteValeur,
        'id_role': idRoleValeur,
        'id_entite': idEntiteValeur,
        'id_process': idProcessValeur,
        'acces_audit': isAudit,
        'acces_pilotage': isPilotage,
        'acces_rapport': isRapport,
      });

      if (response == null) {
        const message = "Votre contributeur a été enregistré avec succès";
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
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchRole().then((refs) {
      // print(refs);
      globalRole = refs;
    }).catchError((error) {});
    fetchEntite().then((refs) {
      //print(refs);
      globalentite = refs;
    }).catchError((error) {});
    fetchProcessus().then((refs) {
      //print(refs);
      globalProcessus = refs;
    }).catchError((error) {});

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 900,
            height: 850,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "AJOUTER UN NOUVEAU CONTRIBUTEUR",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: image == null
                                      ? Image.asset(
                                          imgAvatar,
                                          width: 70,
                                        )
                                      : Image.network(
                                          image!,
                                          width: 70,
                                        )),
                              const SizedBox(
                                height: 10,
                              ),
                              buttonIcon(
                                  tap: () {
                                    _getImage();
                                  },
                                  width: 120,
                                  text: "Photo",
                                  backgroundColor: primaryColor,
                                  color: Colors.white,
                                  icon: Icons.add),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: ComboPara(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez selectionner la civilité";
                                  }
                                  return null;
                                },
                                listValeur: const [
                                  "Monsieur",
                                  "Madame",
                                  "Mademoiselle"
                                ],
                                labeltext: "Civilité",
                                onChanged: (dynamic selectedValue) {
                                  civiliteValeur = selectedValue;
                                  print(
                                      "La valeur civilite est : $civiliteValeur");
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 900,
                        height: 350,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 400,
                              height: 350,
                              child: Column(
                                children: [
                                  textfieldIcon(
                                      autofocus: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir le nom";
                                        }
                                        return null;
                                      },
                                      controller: nomController,
                                      hintText: "Veillez saisir son nom",
                                      label: "Nom du contributeur"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir les prénom";
                                        }
                                        return null;
                                      },
                                      controller: prenomController,
                                      hintText: "Veillez saisir ses prénoms ",
                                      label: "Prénoms du contributeur"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir le Email";
                                        }
                                        return null;
                                      },
                                      controller: emailController,
                                      hintText: "Veillez saisir son Email",
                                      label: "Email du contributeur"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ComboPara(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez selectionner son niveau d'accès";
                                        }
                                        return null;
                                      },
                                      listValeur: globalRole,
                                      labeltext: "Selection du niveau d'accès",
                                      onChanged: (selectedValue) async {
                                        retrouverRole(selectedValue);
                                      }),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 400,
                              height: 350,
                              child: Column(
                                children: [
                                  textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir le contact";
                                        }
                                        return null;
                                      },
                                      controller: contactController,
                                      hintText: "Veillez saisir son contact",
                                      label: "Contact du contributeur"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir l'adresse";
                                        }
                                        return null;
                                      },
                                      controller: adresseController,
                                      hintText: "Son lieu d'habitation",
                                      label: "Domiciliation du contributeur"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir la fonstion";
                                        }
                                        return null;
                                      },
                                      controller: fonctionController,
                                      hintText: "Son poste dans la structure",
                                      label: "Fonction du contributeur"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ComboPara(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez selectionner son entité de service";
                                        }
                                        return null;
                                      },
                                      listValeur: globalentite,
                                      labeltext: "Selection de l'entité",
                                      onChanged: (selectedValue) async {
                                        retrouverEntite(selectedValue);
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 500,
                        height: 100,
                        child: ComboPara(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Svp veuillez selectionner son processus";
                              }
                              return null;
                            },
                            listValeur: globalProcessus,
                            labeltext: "Selection du processus",
                            onChanged: (selectedValue) async {
                              retrouverProcess(selectedValue);
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 600,
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: const Text('Accès Audit'),
                                value: isAudit,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isAudit = value ?? false;
                                    print("Audit $value");
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: const Text('Accès Pilotage'),
                                value: isPilotage,
                                onChanged: (bool? value) {
                                  setState(() {
                                    print("Pilotage $value");
                                    isPilotage = value ?? false;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: const Text('Accès Rapport'),
                                value: isRapport,
                                onChanged: (bool? value) {
                                  setState(() {
                                    print("Rapport $value");
                                    isRapport = value ?? false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buttonType(
                          tap: () async {
                            if (_formKey.currentState!.validate()) {
                              await _CreateData(
                                  context); // Correction : await pour attendre la fin de l'exécution de la fonction
                            }
                          },
                          color: Colors.amber,
                          hovercolor: Colors.amberAccent,
                          text: "Enregistrer")
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMULAIRE D'AJOUT DES INDICATEURS :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class AjoutIndicateur extends StatefulWidget {
  const AjoutIndicateur({super.key});

  @override
  State<AjoutIndicateur> createState() => _AjoutIndicateurState();
}

class _AjoutIndicateurState extends State<AjoutIndicateur> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final refController = TextEditingController();
  final intController = TextEditingController();
  final defController = TextEditingController();
  final oddController = TextEditingController();
  final griController = TextEditingController();
  final freController = TextEditingController();
  Set<List<dynamic>> idsRec = {};
  List<dynamic> idProcess = [];
  List<dynamic> idCritere = [];
  List<dynamic> idTermino = [];
  List<dynamic> idUnite = [];
  List<dynamic> idType = [];
  late int idProcessValeur;
  late int idCritereValeur;
  late int idUniteValeur;
  late int idTypeValeur;
  late int idTerminoValeur;
  late String frequenceValeur;

  Future<Set<List>> fetchidCombo() async {
    final response1 = await Supabase.instance.client
        .from('processus')
        .select('id_process,ref_process');
    List<dynamic> idsProcess =
        response1.map((process) => process['id_process']).toList();

    final response2 = await Supabase.instance.client
        .from('terminologie')
        .select('id_termino,ref_termino');
    List<dynamic> idsTermino =
        response2.map((axe) => axe['id_termino']).toList();

    final response3 = await Supabase.instance.client
        .from('unite')
        .select('id_unite,ref_unite');
    List<dynamic> idsUnite =
        response3.map((unite) => unite['id_unite']).toList();

    final response4 =
        await Supabase.instance.client.from('type').select('id_type,ref_type');
    List<dynamic> idsType = response4.map((type) => type['id_type']).toList();

    final response5 = await Supabase.instance.client
        .from('critere')
        .select('id_critere,ref_critere');
    List<dynamic> idsCritere =
        response5.map((critere) => critere['id_critere']).toList();

    return {idsProcess, idsTermino, idsUnite, idsType, idsCritere};
  }

  Future<void> getData() async {
    Set<List> comboData = await fetchidCombo();
    List<dynamic> idsProcess = comboData.elementAt(0);
    List<dynamic> idsTermino = comboData.elementAt(1);
    List<dynamic> idsUnite = comboData.elementAt(2);
    List<dynamic> idsType = comboData.elementAt(3);
    List<dynamic> idsCritere = comboData.elementAt(4);

    idProcess = idsProcess;
    idTermino = idsTermino;
    idUnite = idsUnite;
    idType = idsType;
    idCritere = idsCritere;

    // Utilisez idsProcess comme nécessaire
    // print("Processus est $idProcess"); // Cela imprime les idsProcess récupérés
    // print("Terminologie est $idTermino"); // Cela imprime les idsProcess récupérés
    // print("Unite est $idUnite"); // Cela imprime les idsProcess récupérés
    // print("Type est $idType"); // Cela imprime les idsProcess récupérés
  }

  @override
  void initState() {
    super.initState();
    getData(); // Appel de getData() lorsque le widget est créé
  }

  dynamic retrouverProcess(dynamic selectedValue) async {
    int index = globalProcessus.indexOf(selectedValue);
    if (index != -1 && index < idProcess.length) {
      //print(globalProcessus);
      //print(idProcess);
      idProcessValeur = idProcess[index];
      //print("son identifiant est : $idProcessValeur");
      return idProcessValeur;
    } else {
      // print(globalProcessus);
      // print(idProcess);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverCritere(dynamic selectedValue) async {
    int index = globalCritere.indexOf(selectedValue);
    if (index != -1 && index < idCritere.length) {
      //print(globalProcessus);
      //print(idProcess);
      idCritereValeur = idCritere[index];
      //print("son identifiant est : $idProcessValeur");
      return idCritereValeur;
    } else {
      // print(globalProcessus);
      // print(idProcess);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverunite(dynamic selectedValue) async {
    int index = globalUnite.indexOf(selectedValue);
    if (index != -1 && index < idUnite.length) {
      //print(globalUnite);
      //print(idUnite);
      idUniteValeur = idUnite[index];
      //print("son identifiant est : $idUniteValeur");
      return idUniteValeur;
    } else {
      // print(globaluniteus);
      // print(idunite);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverType(dynamic selectedValue) async {
    int index = globalType.indexOf(selectedValue);
    if (index != -1 && index < idType.length) {
      //print(globalType);
      //print(idType);
      idTypeValeur = idType[index];
      // print("son identifiant est : $idTypeValeur");
      return idTypeValeur;
    } else {
      // print(globalTypeus);
      // print(idType);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverTermino(dynamic selectedValue) async {
    int index = globalTermino.indexOf(selectedValue);
    if (index != -1 && index < idTermino.length) {
      // print(globalTermino);
      //print(idTermino);
      idTerminoValeur = idTermino[index];
      //print("son identifiant est : $idTerminoValeur");
      return idTerminoValeur;
    } else {
      // print(globalTerminous);
      // print(idTermino);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _CreateData(BuildContext context) async {
    final refIndic = refController.text;
    final numero = numeDerValeur;
    final intitule = intController.text;
    final defini = defController.text;
    final odd = oddController.text;
    final gri = griController.text;

    final response = await Supabase.instance.client.from('indicateur').insert({
      'ref_indic': refIndic,
      'num_indic': numero,
      'intitule_indic': intitule,
      'definition_indic': defini,
      'odd': odd,
      'gri': gri,
      'id_process': idProcessValeur,
      'id_critere': idCritereValeur,
      'id_termino': idTerminoValeur,
      'id_unite': idUniteValeur,
      'id_type': idTypeValeur,
      'frequence': frequenceValeur,
    });
    try {
      if (response == null) {
        const message = "L'indicateur a été enregistré avec succès";
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
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchProcessus().then((refs) {
      // print(refs);
      globalProcessus = refs;
    }).catchError((error) {});
    fetchCritere().then((refs) {
      // print(refs);
      globalCritere = refs;
    }).catchError((error) {});
    fetchTermino().then((refs) {
      //print(refs);
      globalTermino = refs;
    }).catchError((error) {});
    fetchUnite().then((refs) {
      //print(refs);
      globalUnite = refs;
    }).catchError((error) {});
    fetchType().then((refs) {
      //print(refs);
      globalType = refs;
    }).catchError((error) {});

    mettreAJourTextController().then((nouvelleValeur) {
  numeDerValeur = nouvelleValeur;
  print('La valeur mise à jour est: $nouvelleValeur');
}).catchError((error) {
  print('Une erreur s\'est produite lors de la mise à jour: $error');
});
  final numController =  TextEditingController(text: numeDerValeur.toString());
  
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 900,
            height: 715,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "AJOUTER UN NOUVEL INDICATEUR",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    textfieldIcon(
                                      readOnly: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir le numéro de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Numéro de l'indicateur",
                                      controller: numController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                      autofocus: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir l'intitulé de l'indicateur'";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Intitulé de l'indicateur",
                                      controller: intController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir le gri de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Gri de l'indicateur",
                                      controller: griController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboPara(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner son type de calcul";
                                          }
                                          return null;
                                        },
                                        listValeur: globalType,
                                        labeltext:
                                            "Selection du type de calcul",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverType(selectedValue);
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboPara(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner son crtère";
                                          }
                                          return null;
                                        },
                                        listValeur: globalCritere,
                                        labeltext: "Selection du critère",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverCritere(selectedValue);
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboPara(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner sa fréquence";
                                          }
                                          return null;
                                        },
                                        listValeur: const [
                                          "Quotidien",
                                          "Hebdomadaire",
                                          " Mensuelle",
                                          "Trimestrielle",
                                          "Semestrielle",
                                          "Annuelle"
                                        ],
                                        labeltext: "Selection de la fréquence",
                                        onChanged: (dynamic selectedValue) {
                                          frequenceValeur = selectedValue;
                                          print(
                                              "La valeur sélectionnée est : $frequenceValeur");
                                        }),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 400,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir la réference de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Réference de l'indicateur",
                                      controller: refController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir la définition de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Définition l'indicateur",
                                      controller: defController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    textfieldIcon(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Svp veuillez saisir l'odd'de l'indicateur";
                                        }
                                        return null;
                                      },
                                      hintText: "",
                                      label: "Odd de l'indicateur",
                                      controller: oddController,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboPara(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner sa terminologie";
                                          }
                                          return null;
                                        },
                                        listValeur: globalTermino,
                                        labeltext:
                                            "Selection de la terminologie",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverTermino(selectedValue);
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboPara(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner l'unité";
                                          }
                                          return null;
                                        },
                                        listValeur: globalUnite,
                                        labeltext: "Selection de l'unité",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverunite(selectedValue);
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ComboPara(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Svp veuillez selectionner son processus";
                                          }
                                          return null;
                                        },
                                        listValeur: globalProcessus,
                                        labeltext: "Selection du processus",
                                        onChanged: (dynamic selectedValue) {
                                          retrouverProcess(selectedValue);
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buttonType(
                              tap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await _CreateData(
                                      context); // Correction : await pour attendre la fin de l'exécution de la fonction
                                }
                                // Correction : Appel de la fonction anonyme ici
                              },
                              color: Colors.purple,
                              hovercolor: Colors.purpleAccent,
                              text: "Enregistrer")
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMULAIRE D'AJOUT DES ENTITES :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class AjoutEntite extends StatefulWidget {
  const AjoutEntite({super.key});

  @override
  State<AjoutEntite> createState() => _AjoutEntiteState();
}

class _AjoutEntiteState extends State<AjoutEntite> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final abrController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  Set<List<dynamic>> idsRec = {};
  List<dynamic> idFiliale = [];
  List<dynamic> idVille = [];
  late int idFilialeValeur;
  late int idVilleValeur;

  Future<Set<List>> fetchidCombo() async {
    final response1 =
        await Supabase.instance.client.from('filiale').select('id_filiale');
    List<dynamic> idsFiliale =
        response1.map((filiale) => filiale['id_filiale']).toList();

    final response2 =
        await Supabase.instance.client.from('ville').select('id_ville');
    List<dynamic> idsVille =
        response2.map((ville) => ville['id_ville']).toList();

    return {idsFiliale, idsVille};
  }

  Future<void> getData() async {
    Set<List> comboData = await fetchidCombo();
    List<dynamic> idsFiliale = comboData.elementAt(0);
    List<dynamic> idsVille = comboData.elementAt(1);
    idFiliale = idsFiliale;
    idVille = idsVille;

    print("filiaile est $idFiliale"); // Cela imprime les idsRole récupérés
    print("ville est $idVille"); // Cela imprime les idsEntite récupérés
  }

  @override
  void initState() {
    super.initState();
    getData(); // Appel de getData() lorsque le widget est créé
  }

  dynamic retrouverFiliale(dynamic selectedValue) async {
    int index = globalFiliale.indexOf(selectedValue);
    if (index != -1 && index < idFiliale.length) {
      //print(globalFiliale);
      //print(idProcess);
      idFilialeValeur = idFiliale[index];
      print("son identifiant est : $idFilialeValeur");
      return idFilialeValeur;
    } else {
      // print(globalFiliale);
      // print(idProcess);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  dynamic retrouverVille(dynamic selectedValue) async {
    int index = globalVille.indexOf(selectedValue);
    if (index != -1 && index < idVille.length) {
      //print(globalVille);
      //print(idVille);
      idVilleValeur = idVille[index];
      print("son identifiant est : $idVilleValeur");
      return idVilleValeur;
    } else {
      // print(globalVille);
      // print(idVille);
      // print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _CreateData(BuildContext context) async {
    final nom = nomController.text;
    final abr = abrController.text;
    final email = emailController.text;
    final contact = contactController.text;

    try {
      final response = await Supabase.instance.client.from('entite').insert({
        'nom_entite': nom,
        'abr_entite': abr,
        'email_entite': email,
        'contact_entite': contact,
        'id_filiale': idFilialeValeur,
        'id_ville': idVilleValeur,
      });

      if (response == null) {
        const message = "L'entité a été enregistré avec succès";
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
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchFiliale().then((refs) {
      // print(refs);
      globalFiliale = refs;
    }).catchError((error) {});
    fetchVille().then((refs) {
      //print(refs);
      globalVille = refs;
    }).catchError((error) {});

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 600,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "AJOUTER UNE NOUVELLE ENTITE",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le nom de l'entité";
                                  }
                                  return null;
                                },
                                controller: nomController,
                                hintText: "Veillez saisir le nom de l'entité",
                                label: "Nom de l'entités"),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir l'abréviation de l'entité";
                                  }
                                  return null;
                                },
                                controller: abrController,
                                hintText:
                                    "Veillez saisir l'abréviation de l'entité",
                                label: "Abréviation de l'Entité"),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le Email de l'entité";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                hintText:
                                    "veuillez saisir le Email de l'entité",
                                label: "Email de l'entité"),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le contact de l'entité";
                                  }
                                  return null;
                                },
                                controller: contactController,
                                hintText:
                                    "Veillez saisir le contact de l'entité",
                                label: "Contact de l'Entité"),
                            const SizedBox(
                              height: 10,
                            ),
                            ComboPara(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez selectionner la filiale de l'entité";
                                  }
                                  return null;
                                },
                                listValeur: globalFiliale,
                                labeltext: "Selection de la filiale",
                                onChanged: (selectedValue) async {
                                  retrouverFiliale(selectedValue);
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            ComboPara(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez selectionner la ville de l'entité";
                                  }
                                  return null;
                                },
                                listValeur: globalVille,
                                labeltext: "Selection de la ville",
                                onChanged: (selectedValue) async {
                                  retrouverVille(selectedValue);
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            buttonType(
                                tap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await _CreateData(
                                        context); // Correction : await pour attendre la fin de l'exécution de la fonction
                                  }
                                },
                                color: const Color.fromARGB(255, 15, 108, 184),
                                hovercolor:
                                    const Color.fromARGB(255, 107, 160, 252),
                                text: "Sauvegarder")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMULAIRE D'AJOUT DES FILIALES:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class AjoutFiliale extends StatefulWidget {
  const AjoutFiliale({super.key});

  @override
  State<AjoutFiliale> createState() => _AjoutFilialeState();
}

class _AjoutFilialeState extends State<AjoutFiliale> {
  final _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  Set<List<dynamic>> idsRec = {};
  List<dynamic> idFiliere = [];
  late int idfiliereValeur;
  String? image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = pickedImage.path;
        print(image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<List> fetchidFiliere() async {
    final response =
        await Supabase.instance.client.from('filiere').select('id_filiere');
    List<dynamic> ids =
        response.map((filiere) => filiere['id_filiere']).toList();
    return ids;
  }

  dynamic retrouverFiliere(dynamic selectedValue) async {
    int index = globalFiliere.indexOf(selectedValue);
    if (index != -1 && index < idFiliere.length) {
      print(globalFiliere);
      print(idFiliere);
      idfiliereValeur = idFiliere[index];
      print("son identifiant est : $idfiliereValeur");
      return idfiliereValeur;
    } else {
      print(globalFiliere);
      print(idFiliere);
      print("NULL");
      return null; // Retourne null si la valeur n'est pas trouvée ou si l'index dépasse la longueur de la liste A
    }
  }

  Future<void> _CreateData(BuildContext context) async {
    final nomfiliale = nomController.text;
    final emailfiliale = emailController.text;
    final contactfiliale = contactController.text;

    final response = await Supabase.instance.client.from('filiale').insert({
      'nom_filiale': nomfiliale,
      'email_filiale': emailfiliale,
      'contact_filiale': contactfiliale,
      'logo_filiale': image,
      'id_filiere': idfiliereValeur,
    });

    if (response == null) {
      const message = "La filiale a été enregistrée avec succès";
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
    fetchFiliere().then((refs) {
      // print(refs);
      globalFiliere = refs;
    }).catchError((error) {});
    fetchidFiliere().then((ids) {
      idFiliere = ids;
    }).catchError((error) {});

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: Container(
            width: 600,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "AJOUTER UNE NOUVELLE FILIALE",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              image == null
                                  ? Image.asset(
                                      imgAvatar,
                                      width: 70,
                                    )
                                  : Image.network(
                                      image!,
                                      width: 70,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              buttonIcon(
                                  tap: () {
                                    _getImage();
                                  },
                                  width: 120,
                                  text: "Logo",
                                  backgroundColor: primaryColor,
                                  color: Colors.white,
                                  icon: Icons.add),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                              width: 300,
                              child: ComboPara(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Svp veuillez selectionner la filière";
                                    }
                                    return null;
                                  },
                                  listValeur: globalFiliere,
                                  labeltext: "Selection de la filière",
                                  onChanged: (dynamic selectedValue) {
                                    retrouverFiliere(selectedValue);
                                  })),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            textfieldIcon(
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le nom de la filiale";
                                  }
                                  return null;
                                },
                                hintText: "Veillez saisir le nom de la filiale",
                                label: "Nom Filiale",
                                controller: nomController),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le Email de la filiale";
                                  }
                                  return null;
                                },
                                hintText:
                                    "Veillez saisir le Email de la filiale",
                                label: "Email de la filiale",
                                controller: emailController),
                            const SizedBox(
                              height: 10,
                            ),
                            textfieldIcon(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Svp veuillez saisir le contact de la filiale";
                                  }
                                  return null;
                                },
                                hintText:
                                    "Veillez saisir le contact de la filiale",
                                label: "Contact de la filiale",
                                controller: contactController),
                            const SizedBox(
                              height: 20,
                            ),
                            buttonType(
                                tap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await _CreateData(
                                        context); // Correction : await pour attendre la fin de l'exécution de la fonction
                                  }
                                },
                                color: Colors.green,
                                hovercolor: Colors.greenAccent,
                                text: "Sauvegarder")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
