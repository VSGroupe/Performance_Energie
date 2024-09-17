import 'package:flutter/material.dart';
import 'package:perf_energie/widgets/Constant/AppColor.dart';
import 'package:perf_energie/widgets/GlobaleVariable/date.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide AnimationType;
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// DIAGRAMME DES COLLECTEURS D'INDICATEURS::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class ChartOverview extends StatefulWidget {
  const ChartOverview({
    Key? key,
  }) : super(key: key);

  @override
  State<ChartOverview> createState() => _ChartOverviewState();
}

class _ChartOverviewState extends State<ChartOverview> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 70,
                startDegreeOffset: -90,
                sections: showingSections(),
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                )),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  "150",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text(
                  "(collectés et validés)",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "sur 450 indicateurs",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 15.0;
      final radius = isTouched ? 40.0 : 30.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: Colors.green,
              value: 40,
              title: '40',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ));
        case 1:
          return PieChartSectionData(
              color: Colors.amber,
              value: 60,
              title: '60',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ));
        case 2:
          return PieChartSectionData(
              color: Colors.red,
              value: 100,
              title: '100',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ));
        default:
          throw Error();
      }
    });
  }
}

//DIAGRAMME DES SUIVIS MENSUELS:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class SuiviMensuelChart extends StatefulWidget {
  const SuiviMensuelChart({Key? key}) : super(key: key);

  @override
  State<SuiviMensuelChart> createState() => _SuiviMensuelChartState();
}

class _SuiviMensuelChartState extends State<SuiviMensuelChart> {
  late double _columnWidth;
  late double _columnSpacing;
  List<ChartSampleData>? chartData;
  TooltipBehavior? _tooltipBehavior;
  bool _isLoaded = false;
  bool isCardView = true;

  void initialisation() async {
    _columnWidth = 0.8;
    _columnSpacing = 0.2;
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Jan.', y: 16, secondSeriesYValue: 8, thirdSeriesYValue: 13),
      ChartSampleData(
          x: 'Fév.', y: 8, secondSeriesYValue: 10, thirdSeriesYValue: 7),
      ChartSampleData(
          x: 'Mars', y: 12, secondSeriesYValue: 10, thirdSeriesYValue: 5),
      ChartSampleData(
          x: 'Avril', y: 4, secondSeriesYValue: 8, thirdSeriesYValue: 14),
      ChartSampleData(
          x: 'Mai', y: 4, secondSeriesYValue: 8, thirdSeriesYValue: 14),
      ChartSampleData(
          x: 'Juin', y: 16, secondSeriesYValue: 8, thirdSeriesYValue: 13),
      ChartSampleData(
          x: 'Jui.', y: 8, secondSeriesYValue: 10, thirdSeriesYValue: 7),
      ChartSampleData(
          x: 'Août', y: 12, secondSeriesYValue: 10, thirdSeriesYValue: 5),
      ChartSampleData(
          x: 'Sept.', y: 4, secondSeriesYValue: 8, thirdSeriesYValue: 14),
      ChartSampleData(
          x: 'Oct.', y: 4, secondSeriesYValue: 8, thirdSeriesYValue: 14),
      ChartSampleData(
          x: 'Nov.', y: 4, secondSeriesYValue: 8, thirdSeriesYValue: 14),
      ChartSampleData(
          x: 'Déc.', y: 4, secondSeriesYValue: 8, thirdSeriesYValue: 14)
    ];
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      _isLoaded = true;
    });
  }

  Image _getImage(int index) {
    final List<Image> images = <Image>[
      Image.asset('assets/icons/Rond_rouge.png'),
      Image.asset('assets/icons/Rond_orange.png'),
      Image.asset('assets/icons/Rond_vert.png'),
    ];
    return images[index];
  }

  @override
  void initState() {
    initialisation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? _buildSpacingColumnChart()
        : const Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                    strokeWidth: 4,
                  )),
              SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                      color: Colors.amber, strokeWidth: 4)),
            ],
          );
  }

  SfCartesianChart _buildSpacingColumnChart() {
    int annee = DateTime.now().year;
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Suivi des données mensuelles $annee : CIE Siège',
          textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline)),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: "", textStyle: const TextStyle(fontSize: 14)),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          title: AxisTitle(text: "Nombre d'occurrence"),
          maximum: 20,
          minimum: 0,
          interval: 5,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getDefaultColumn(),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        orientation: LegendItemOrientation.horizontal,
        overflowMode: LegendItemOverflowMode.wrap,
        toggleSeriesVisibility: false,
        legendItemBuilder:
            (String name, dynamic series, dynamic point, int index) {
          return SizedBox(
            height: 40,
            width: index == 1 ? 95 : name.length.toDouble() * 14,
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: _getImage(index),
                ),
                const SizedBox(
                  width: 10,
                  height: 10,
                ),
                Text(name),
                const SizedBox(
                  width: 10,
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  ///Get the column series
  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumn() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          width: isCardView ? 0.5 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          dataSource: chartData!,
          color: Colors.red,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Champ vide'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData!,
          width: isCardView ? 0.5 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.amber,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Saisie'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData!,
          width: isCardView ? 0.5 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.green,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
          name: 'Validation'),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class ChartSampleData {
  final String x;
  final double y;
  final double secondSeriesYValue;
  final double thirdSeriesYValue;
  ChartSampleData({
    required this.thirdSeriesYValue,
    required this.x,
    required this.y,
    required this.secondSeriesYValue,
  });
}

// DIAGRAMME DES PERFORMANCES EN JEUX ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class PerformanceEnjeux extends StatefulWidget {
  const PerformanceEnjeux({Key? key}) : super(key: key);

  @override
  State<PerformanceEnjeux> createState() => _PerformanceEnjeuxState();
}

class _PerformanceEnjeuxState extends State<PerformanceEnjeux> {
  late double _columnWidth;
  late double _columnSpacing;
  List<ChartSampleData1>? chartData;
  TooltipBehavior? _tooltipBehavior;
  bool _isLoaded = false;
  bool isCardView = true;

  void initialisation() async {
    _columnWidth = 0.8;
    _columnSpacing = 0.2;
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData = <ChartSampleData1>[
      ChartSampleData1(
          x: '1.a Gouvernance DD et stratégie',
          y: 16,
          secondSeriesYValue: 8,
          thirdSeriesYValue: 13),
      ChartSampleData1(
          x: '1.b Pilotage DD',
          y: 12,
          secondSeriesYValue: 10,
          thirdSeriesYValue: 5),
      ChartSampleData1(
          x: '2. Éthique des affaires et achats responsables',
          y: 4,
          secondSeriesYValue: 8,
          thirdSeriesYValue: 14),
      ChartSampleData1(
          x: '3. Intégration des attentes DD des clients et consommateurs',
          y: 16,
          secondSeriesYValue: 8,
          thirdSeriesYValue: 13),
      ChartSampleData1(
          x: '4. Égalité de traitement',
          y: 8,
          secondSeriesYValue: 10,
          thirdSeriesYValue: 7),
      ChartSampleData1(
          x: '5. Conditions de travail',
          y: 12,
          secondSeriesYValue: 10,
          thirdSeriesYValue: 5),
      ChartSampleData1(
          x: '6. Amélioration du cadre de vie',
          y: 4,
          secondSeriesYValue: 8,
          thirdSeriesYValue: 14),
      ChartSampleData1(
          x: '7. Inclusion sociale et développement des communautés',
          y: 16,
          secondSeriesYValue: 8,
          thirdSeriesYValue: 13),
      ChartSampleData1(
          x: '8. Changement climatique et déforestation',
          y: 8,
          secondSeriesYValue: 10,
          thirdSeriesYValue: 7),
      ChartSampleData1(
          x: '9. Gestion et traitement de l’eau',
          y: 12,
          secondSeriesYValue: 10,
          thirdSeriesYValue: 5),
      ChartSampleData1(
          x: '10. Gestion des ressources et déchets',
          y: 4,
          secondSeriesYValue: 8,
          thirdSeriesYValue: 14)
    ];
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  void initState() {
    initialisation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? _buildSpacingColumnChart()
        : const Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                    strokeWidth: 4,
                  )),
              SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                      color: Colors.amber, strokeWidth: 4)),
            ],
          );
  }

  Material _buildSpacingColumnChart() {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
        ),
        width: 1300,
        height: 800,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          title: ChartTitle(
              text: 'PERFORMANCE PAR ENJEU PRIORITAIRE',
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  decoration: TextDecoration.underline)),
          primaryXAxis: CategoryAxis(
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            title: AxisTitle(
                text: "Les enjeux prioritaires",
                textStyle: const TextStyle(fontSize: 18)),
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
              labelAlignment: LabelAlignment.center,
              title: AxisTitle(
                  text: "Performance en %",
                  textStyle: const TextStyle(fontSize: 18)),
              maximum: 20,
              minimum: 0,
              interval: 5,
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0)),
          series: _getDefaultColumn(),
          legend: Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
        ),
      ),
    );
  }

  ///Get the column series
  List<BarSeries<ChartSampleData1, String>> _getDefaultColumn() {
    return <BarSeries<ChartSampleData1, String>>[
      BarSeries<ChartSampleData1, String>(

          /// To apply the column width here.
          width: isCardView ? 0.8 : _columnWidth,

          /// To apply the spacing betweeen to two columns here.
          spacing: isCardView ? 0.2 : _columnSpacing,
          dataSource: chartData!,
          color: const Color.fromARGB(255, 102, 247, 179),
          xValueMapper: (ChartSampleData1 sales, _) => sales.x,
          yValueMapper: (ChartSampleData1 sales, _) => sales.y,
          name: '$prevYear'),
      BarSeries<ChartSampleData1, String>(
          dataSource: chartData!,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData1 sales, _) => sales.x,
          yValueMapper: (ChartSampleData1 sales, _) => sales.secondSeriesYValue,
          name: '$annee'),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class ChartSampleData1 {
  final String x;
  final double y;
  final double secondSeriesYValue;
  final double thirdSeriesYValue;
  ChartSampleData1({
    required this.thirdSeriesYValue,
    required this.x,
    required this.y,
    required this.secondSeriesYValue,
  });
}

// SPEEDOMETRE DES PERFOMANCE ANNUELLES::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class speedPerfYear extends StatefulWidget {
  final double performGloabal;

  const speedPerfYear({
    Key? key,
    required this.performGloabal,
  }) : super(key: key);

  @override
  State<speedPerfYear> createState() => _speedPerfYearState();
}

class _speedPerfYearState extends State<speedPerfYear> {
  bool isCardView = true;
  bool isWebFullView = true;
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        title: GaugeTitle(
            text: 'Performance Globale $annee',
            textStyle: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: 100,
              interval: 10,
              minorTicksPerInterval: 9,
              showAxisLine: false,
              radiusFactor: isWebFullView ? 0.8 : 0.9,
              labelOffset: 8,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 95,
                    endValue: 100,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(190, 16, 67, 235)),
                GaugeRange(
                    startValue: 85,
                    endValue: 94,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(190, 4, 87, 1)),
                GaugeRange(
                    startValue: 73,
                    endValue: 84,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(190, 8, 170, 21)),
                GaugeRange(
                    startValue: 61,
                    endValue: 72,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(190, 19, 236, 48)),
                GaugeRange(
                    startValue: 49,
                    endValue: 60,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(164, 196, 193, 15)),
                GaugeRange(
                    startValue: 37,
                    endValue: 48,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(159, 241, 119, 19)),
                GaugeRange(
                    startValue: 25,
                    endValue: 36,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(164, 235, 66, 19)),
                GaugeRange(
                    startValue: 13,
                    endValue: 24,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(164, 255, 6, 6)),
                GaugeRange(
                    startValue: 0,
                    endValue: 12,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(255, 129, 2, 2)),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: widget.performGloabal,
                  needleStartWidth: isCardView ? 0 : 1,
                  needleEndWidth: isCardView ? 5 : 8,
                  animationType: AnimationType.easeOutBack,
                  enableAnimation: true,
                  animationDuration: 1200,
                  knobStyle: KnobStyle(
                      knobRadius: isCardView ? 0.06 : 0.09,
                      borderColor: const Color.fromARGB(255, 31, 30, 29),
                      color: Colors.white,
                      borderWidth: isCardView ? 0.035 : 0.05),
                  tailStyle: TailStyle(
                      color: const Color.fromARGB(255, 228, 66, 3),
                      width: isCardView ? 4 : 8,
                      length: isCardView ? 0.15 : 0.2),
                  needleColor: const Color.fromARGB(255, 223, 2, 2),
                )
              ],
              axisLabelStyle: GaugeTextStyle(fontSize: isCardView ? 10 : 12),
              majorTickStyle: const MajorTickStyle(
                  length: 0.25, lengthUnit: GaugeSizeUnit.factor),
              minorTickStyle: const MinorTickStyle(
                  length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1),
              annotations: <GaugeAnnotation>[
                const GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.35,
                    widget: Text('Performance',
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 1, 100),
                            fontWeight: FontWeight.w900,
                            fontSize: 15))),
                GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.8,
                  widget: Text(
                    "${widget.performGloabal.toStringAsFixed(0)} % ",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              ])
        ]);
  }
}



// SPEEDOMETRE DES PERFOMANCE MENSUELLE::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class speedPerfMois extends StatefulWidget {
  final double performGloabal;

  const speedPerfMois({
    Key? key,
    required this.performGloabal,
  }) : super(key: key);

  @override
  State<speedPerfMois> createState() => _speedPerfMoisState();
}

class _speedPerfMoisState extends State<speedPerfMois> {
  String monthName = getMois();
  bool isCardView = true;
  bool isWebFullView = true;
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        title: GaugeTitle(
            text: 'Performance $monthName',
            textStyle: const TextStyle(fontSize: 17.0, color: Colors.brown, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: 100,
              interval: 20,
              minorTicksPerInterval: 9,
              showAxisLine: false,
              radiusFactor: isWebFullView ? 0.8 : 0.9,
              labelOffset: 8,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 95,
                    endValue: 100,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(190, 16, 67, 235)),
                GaugeRange(
                    startValue: 85,
                    endValue: 94,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(190, 4, 87, 1)),
                GaugeRange(
                    startValue: 73,
                    endValue: 84,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(190, 8, 170, 21)),
                GaugeRange(
                    startValue: 61,
                    endValue: 72,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(190, 19, 236, 48)),
                GaugeRange(
                    startValue: 49,
                    endValue: 60,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(164, 196, 193, 15)),
                GaugeRange(
                    startValue: 37,
                    endValue: 48,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(159, 241, 119, 19)),
                GaugeRange(
                    startValue: 25,
                    endValue: 36,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(164, 235, 66, 19)),
                GaugeRange(
                    startValue: 13,
                    endValue: 24,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(164, 255, 6, 6)),
                GaugeRange(
                    startValue: 0,
                    endValue: 12,
                    startWidth: 0.265,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.265,
                    color: const Color.fromARGB(255, 129, 2, 2)),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: widget.performGloabal,
                  needleStartWidth: isCardView ? 0 : 1,
                  needleEndWidth: isCardView ? 5 : 8,
                  animationType: AnimationType.easeOutBack,
                  enableAnimation: true,
                  animationDuration: 1200,
                  knobStyle: KnobStyle(
                      knobRadius: isCardView ? 0.06 : 0.09,
                      borderColor: const Color.fromARGB(255, 31, 30, 29),
                      color: Colors.white,
                      borderWidth: isCardView ? 0.035 : 0.05),
                  tailStyle: TailStyle(
                      color: const Color.fromARGB(255, 228, 66, 3),
                      width: isCardView ? 4 : 8,
                      length: isCardView ? 0.15 : 0.2),
                  needleColor: const Color.fromARGB(255, 223, 2, 2),
                )
              ],
              axisLabelStyle: GaugeTextStyle(fontSize: isCardView ? 10 : 12),
              majorTickStyle: const MajorTickStyle(
                  length: 0.25, lengthUnit: GaugeSizeUnit.factor),
              minorTickStyle: const MinorTickStyle(
                  length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1),
              annotations: <GaugeAnnotation>[
                const GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.35,
                    widget: Text('Performance',
                        style: TextStyle(
                            color: Color.fromARGB(255, 52, 1, 100),
                            fontWeight: FontWeight.w900,
                            fontSize: 15))),
                GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.8,
                  widget: Text(
                    "${widget.performGloabal.toStringAsFixed(0)} % ",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              ])
        ]);
  }
}


// DIAGRAMME DES PERFOMANCE PAR AXE STRATEGIQUE ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


class PerformancePiliers extends StatefulWidget {
  const PerformancePiliers({Key? key}) : super(key: key);

  @override
  State<PerformancePiliers> createState() => _PerformancePiliersState();
}

class _PerformancePiliersState extends State<PerformancePiliers> {
  late double _columnWidth;
  late double _columnSpacing;
  List<ChartSampleData2>? chartData;
  TooltipBehavior? _tooltipBehavior;
  bool _isLoaded = false;
  bool isCardView = true;

  void initialisation() async {
    _columnWidth = 0.8;
    _columnSpacing = 0.2;
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData = <ChartSampleData2>[
      ChartSampleData2(
          x: 'Gouvernance',
          y: 16,
          secondSeriesYValue: 8,
          thirdSeriesYValue: 13),
      ChartSampleData2(
          x: 'Economie', y: 8, secondSeriesYValue: 10, thirdSeriesYValue: 7),
      ChartSampleData2(
          x: 'Société', y: 12, secondSeriesYValue: 10, thirdSeriesYValue: 5),
      ChartSampleData2(
          x: 'Environnement',
          y: 4,
          secondSeriesYValue: 8,
          thirdSeriesYValue: 14)
    ];
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  void initState() {
    initialisation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? _buildSpacingColumnChart()
        : const Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                    strokeWidth: 4,
                  )),
              SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                      color: Colors.amber, strokeWidth: 4)),
            ],
          );
  }

  SizedBox _buildSpacingColumnChart() {
    return SizedBox(
      height: 430,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(
            text: "",
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                decoration: TextDecoration.underline)),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: "Les axes stratégiques"),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
            title: AxisTitle(text: "Performance en %"),
            maximum: 20,
            minimum: 0,
            interval: 4,
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        series: _getDefaultColumn(),
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
      ),
    );
  }

  ///Get the column series
  List<ColumnSeries<ChartSampleData2, String>> _getDefaultColumn() {
    return <ColumnSeries<ChartSampleData2, String>>[
      ColumnSeries<ChartSampleData2, String>(

          /// To apply the column width here.
          width: isCardView ? 0.8 : _columnWidth,

          /// To apply the spacing betweeen to two columns here.
          spacing: isCardView ? 0.2 : _columnSpacing,
          dataSource: chartData!,
          color: const Color.fromARGB(255, 102, 247, 179),
          xValueMapper: (ChartSampleData2 sales, _) => sales.x,
          yValueMapper: (ChartSampleData2 sales, _) => sales.y,
          name: '$prevYear'),
      ColumnSeries<ChartSampleData2, String>(
          dataSource: chartData!,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData2 sales, _) => sales.x,
          yValueMapper: (ChartSampleData2 sales, _) => sales.secondSeriesYValue,
          name: '$annee'),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class ChartSampleData2 {
  final String x;
  final double y;
  final double secondSeriesYValue;
  final double thirdSeriesYValue;
  ChartSampleData2({
    required this.thirdSeriesYValue,
    required this.x,
    required this.y,
    required this.secondSeriesYValue,
  });
}

// TABLEAU DE CONTROLLE:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

class TBord extends StatelessWidget {
  final int pourcentage;
  final Color? colorpourcentage;
  final String textTitle;
  final String textSousTitle;
  final Color? colortextTitle;
  final double? sizetextTitle;
  final Color? colortext2;
  final double? sizetext2;
  final Color? colortext3;
  final double? sizetext3;
  final double? radiusSize;
  final IconData icon;
  final Color? colorIcon;
  final double? sizeIcon;

  const TBord({
    Key? key,
    required this.pourcentage,
    required this.textTitle,
    required this.textSousTitle,
    this.colortextTitle,
    this.colorpourcentage,
    this.sizetextTitle,
    this.colortext2,
    this.sizetext2,
    this.colortext3,
    this.sizetext3,
    this.radiusSize,
    required this.icon,
    this.colorIcon,
    this.sizeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color couleurPourcentage = ColorUtil.getColorFromValue(pourcentage.toInt());
    String textPourcentage = TextUtil.getColorFromValue(pourcentage.toInt());
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              children: [
                Text(textTitle,
                    style: TextStyle(
                      color: colortextTitle ?? secondColor,
                      fontSize: sizetextTitle ?? 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    )),
                const SizedBox(height: 10),
                Text(textSousTitle,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: sizetextTitle ?? 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  icon,
                  color: colorIcon ?? secondColor,
                  size: sizeIcon ?? 30,
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Text(
                      textPourcentage,
                      style: TextStyle(
                        color: colorpourcentage ?? couleurPourcentage,
                        fontSize: sizetext2 ?? 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "$pourcentage % de Rendements",
                      style: TextStyle(
                          color: colorpourcentage ?? couleurPourcentage,
                          fontSize: sizetext3 ?? 12,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}

