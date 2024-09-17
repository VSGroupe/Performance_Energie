import 'package:flutter/material.dart';
import "package:pluto_grid/pluto_grid.dart";

/// PlutoGrid Example
//
/// For more examples, go to the demo web link on the github below.
class TabModifIndic extends StatefulWidget {
  const TabModifIndic({Key? key}) : super(key: key);

  @override
  State<TabModifIndic> createState() => _TabModifIndicState();
}

class _TabModifIndicState extends State<TabModifIndic> {
  bool isNull = true;

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      enableRowChecked: true,
      width: 150,
      enableSorting: true,
      readOnly: true,
      title: 'Ref',
      field: 'ref',
      type: PlutoColumnType.text(),
      footerRenderer: (rendererContext) {
        return const Text("Mes indicateurs");
      },
    ),
    PlutoColumn(
     textAlign: PlutoColumnTextAlign.right,
      width: 550,
      title: 'Intitulé',
      field: 'intitule',
      type: PlutoColumnType.text(),
      footerRenderer: (rendererContext) {
        return const Text("Mes indicateurs");
      },
    ),
    PlutoColumn(
     textAlign: PlutoColumnTextAlign.right,
      width: 300,
      readOnly: true,
      title: 'Processus',
      field: 'processus',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
     textAlign: PlutoColumnTextAlign.right,
      width: 200,
      title: 'Mois',
      field: 'mois',
      type: PlutoColumnType.select(<String>[
        'Janvier',
        'Décembre',
        'Novembre',
      ]),
      footerRenderer: (rendererContext) {
        return const Text("Mois en cours", textAlign:TextAlign.center, );
      },
    ),
    PlutoColumn(
  textAlign: PlutoColumnTextAlign.right,
  width: 250,
  title: 'Réalisé 2024',
  field: 'realise 2024',
  type: PlutoColumnType.currency(
    symbol: "",
    decimalDigits: 0,
    negative: false,
  ),
  formatter: (value) {
    // Condition pour afficher "Null" si la valeur est 0
    if (value == 0) {
      return 'Null';
    } else {
      // Sinon, afficher la valeur normale
      return value.toString();
    }
  },
  footerRenderer: (rendererContext) {
    return PlutoAggregateColumnFooter(
      rendererContext: rendererContext,
      formatAsCurrency: true,
      type: PlutoAggregateColumnType.sum,
      format: '#,###',
      alignment: Alignment.centerLeft,
      titleSpanBuilder: (text) {
        return [
          const TextSpan(
            text: 'Total',
            style: TextStyle(color: Colors.red),
          ),
          const TextSpan(text: ' : '),
          TextSpan(text: text),
        ];
      },
    );
  },
),

    PlutoColumn(
     textAlign: PlutoColumnTextAlign.right,
      width: 250,
      title: 'Cible',
      field: 'cible',
      type: PlutoColumnType.currency(
        symbol: "",
        decimalDigits: 0,
        negative: false,
      ),
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          format: '# ###',
          alignment: Alignment.centerLeft,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(
                text: 'Total',
                style: TextStyle(color: Colors.red),
              ),
              const TextSpan(text: ' : '),
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
     textAlign: PlutoColumnTextAlign.right,
      width: 180,
      title: 'Ecart',
      field: 'ecart',
      type: PlutoColumnType.currency(
        symbol: "",
        decimalDigits:0,
        negative: false,
      ),
      formatter: (value) {
        // Ajouter le pourcentage derrière les chiffres
        if (value != null) {
          return '$value %';
        }
        return value;
      },
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          formatAsCurrency: false,
          type: PlutoAggregateColumnType.sum,
          format: '#',
          alignment: Alignment.centerLeft,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(
                text: 'Total',
                style: TextStyle(color: Colors.red),
              ),
              const TextSpan(text: ' : '),
              TextSpan(text: "$text %"),
            ];
          },
        );
      },
    ),
  ];

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'ref': PlutoCell(value: '#1 GEN-001'),
        'intitule': PlutoCell(
            value:
                'Superficie des plantations industrielles (mature et immature)'),
        'processus': PlutoCell(value: 20),
        'realise 2024': PlutoCell(value: 'Programmer'),
        'mois': PlutoCell(value: '2021-01-01'),
        'cible': PlutoCell(value: '09:00'),
        'ecart': PlutoCell(value: 300),
      },
    ),
    PlutoRow(
      cells: {
        'ref': PlutoCell(value: 'user2'),
        'intitule': PlutoCell(value: 'Jack'),
        'processus': PlutoCell(value: 25),
        'realise 2024': PlutoCell(value: 'Designer'),
        'mois': PlutoCell(value: '2021-01-02'),
        'cible': PlutoCell(value: '10:00'),
        'ecart': PlutoCell(value: 400),
      },
    ),
    PlutoRow(
      cells: {
        'ref': PlutoCell(value: 'user3'),
        'intitule': PlutoCell(value: 'Suzi'),
        'processus': PlutoCell(value: 40),
        'realise 2024': PlutoCell(value: 'Owner'),
        'mois': PlutoCell(value: '2021-01-03'),
        'cible': PlutoCell(value: '11:00'),
        'ecart': PlutoCell(value: 700),
      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'Ref', fields: ['ref'], expandedColumn: true),
    PlutoColumnGroup(
        title: 'Indicateurs de performances',
        fields: ['intitule', 'processus']),
    PlutoColumnGroup(
        title: 'Réalisé 2024', fields: ['realise 2024'], expandedColumn: true),
    PlutoColumnGroup(title: 'Objectif 2024', fields: ['mois', 'cible']),
    PlutoColumnGroup(title: 'Ecart', fields: ['ecart'], expandedColumn: true),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager1;
  late final PlutoGridStateManager stateManager2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            padding: const EdgeInsets.all(15),
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              columnGroups: columnGroups,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager1 = event.stateManager;
                stateManager1.setShowColumnFilter(true);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              configuration: const PlutoGridConfiguration(
                localeText: PlutoGridLocaleText.french(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 400,
            padding: const EdgeInsets.all(15),
            child: PlutoGrid(
              columns: columns,
              rows: rows,
              columnGroups: columnGroups,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                stateManager2 = event.stateManager;
                stateManager2.setShowColumnFilter(true);
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              configuration: const PlutoGridConfiguration(
                localeText: PlutoGridLocaleText.french(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
