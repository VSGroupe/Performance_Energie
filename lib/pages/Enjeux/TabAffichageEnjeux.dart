import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:perf_energie/main.dart';
import 'package:perf_energie/pages/Onglet/parametre.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/Constant/ImgConstant.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<List<Map<String, dynamic>>> fetchEnjeuxData() async {
  List<Map<String, dynamic>> enjeuxData =
      await Supabase.instance.client.from('enjeu').select();
  return enjeuxData;
}

Future<List<Map<String, dynamic>>> fetchCritereData() async {
  List<Map<String, dynamic>> critereData =
      await Supabase.instance.client.from('critere').select();
  return critereData;
}

Future<Map<String, List<String>>> fetchElements() async {
  List<Map<String, dynamic>> enjeuxData = await fetchEnjeuxData();
  List<Map<String, dynamic>> critereData = await fetchCritereData();

  // Créez une map pour stocker les éléments
  Map<String, List<String>> elementsMap = {};

  // Parcourez les données de la table 'axe'
  for (var enjeu in enjeuxData) {
    String enjeuName = enjeu['nom_enjeu'];
    List<String> critere = [];

    for (var critereItem in critereData) {
      if (critereItem['id_enjeu'] == enjeu['id_enjeu']) {
        critere.add(critereItem['nom_critere']);
      }
    }

    elementsMap[enjeuName] = critere;
  }
  print(elementsMap);
  return elementsMap;
}

class ListersEnjeux extends StatefulWidget {
  const ListersEnjeux({super.key});

  @override
  State<ListersEnjeux> createState() => _ListersEnjeuxState();
}

class _ListersEnjeuxState extends State<ListersEnjeux> {
  Map<String, List<String>> elements = {};
  List<Map<String, dynamic>> maListe = [];
  bool isLoading = true; // Ajout de la variable isLoading

  @override
  void initState() {
    super.initState();
    fetchElements().then((result) {
      setState(() {
        elements = result;
        isLoading = false; // Mettre isLoading à false une fois les données chargées
      });
    }).catchError((error) {
      print("Erreur lors de la récupération des éléments : $error");
      isLoading = false; // Mettre isLoading à false une fois les données chargées
    });

    // Appeler la fonction numeroterListe pour numéroter la liste
    maListe = numeroterListe(maListe);
  }

  List<Map<String, dynamic>> numeroterListe(List<Map<String, dynamic>> liste) {
    List<Map<String, dynamic>> listeNumerotee = [];
    for (int i = 0; i < liste.length; i++) {
      Map<String, dynamic> element = liste[i];
      element['numero'] = i + 1;
      listeNumerotee.add(element);
    }
    return listeNumerotee;
  }

  @override
  Widget build(BuildContext context) {
    var groupState = Provider.of<GroupState>(context);

    return Scaffold(
      body: isLoading // Vérifier si les données sont en cours de chargement
          ? const Center(child: CircularProgressIndicator()) // Afficher le CircularProgressIndicator si les données sont en cours de chargement
          : GroupListView(
        sectionsCount: elements.keys.length,
        countOfItemInSection: (int section) {
          return elements.values.toList()[section].length;
        },
        itemBuilder: _itemBuilder,
        groupHeaderBuilder: (BuildContext context, int section) {
          String groupName = elements.keys.toList()[section];
          bool isOpen = groupState.openGroups[groupName] ?? false;
          int groupNumber = section + 1;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: InkWell(
               onTap: () {
              setState(() {
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Parametres()),
            );
              });
            },
            onDoubleTap: () { // Double tap pour ouvrir ou fermer les sous-groupes
              setState(() {
                groupState.openGroups[groupName] = !isOpen;
              });
            },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: isOpen ? Colors.transparent  : enjeuColor,
                  border: Border.all(
                    color: isOpen ? enjeuColor : Colors.black,
                    width: 3.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$groupNumber',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: isOpen ? enjeuColor : Colors.white,
                            ),
                          ), 
                          const SizedBox(width: 20,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' ENJEUX',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: isOpen ? enjeuColor : Colors.white,
                                ),
                              ),
                              Text(
                                 groupName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: isOpen ? enjeuColor : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        isOpen
                            ? Icons.close_fullscreen_outlined
                            : Icons.arrow_forward_ios_outlined,
                        color: isOpen ? enjeuColor : Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        sectionSeparatorBuilder: (context, section) =>
            const SizedBox(height: 10),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    var groupState = Provider.of<GroupState>(context);
    String groupName1 = elements.keys.toList()[index.section];
    bool isOpen = groupState.openGroups[groupName1] ?? false;
    String subGroupName = elements[groupName1]![index.index];

    return Visibility(
      visible: isOpen,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 8,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Parametres()),
              );
            },
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(logoEnjeu),
                  ),
                  title: const Text(
                    'Critères',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    subGroupName,
                    style: const TextStyle(
                      color: critereColor,
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  trailing: const Icon(Icons.playlist_add_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
