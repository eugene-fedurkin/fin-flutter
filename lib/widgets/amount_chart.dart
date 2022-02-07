import 'package:flutter/cupertino.dart';
import 'package:organizer/api/categories_api.dart';
import 'package:organizer/db/database.dart';
import 'package:organizer/models/category.dart';
import 'package:organizer/models/cost.dart';
import 'package:pie_chart/pie_chart.dart';

class AmountChart extends StatefulWidget {
  const AmountChart({Key? key}) : super(key: key);

  @override
  _AmountChartState createState() => _AmountChartState();
}

class _AmountChartState extends State<AmountChart> {
  late Future<List<Cost>> costs;
  late List<Category> categories;

  var dataMap = <String, double>{
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  List<Color> colorList = <Color>[];

  static const List<Color> defaultColorList = [
    Color(0xFFff7675),
    Color(0xFF74b9ff),
    Color(0xFF55efc4),
    Color(0xFFffeaa7),
    Color(0xFFa29bfe),
    Color(0xFFfd79a8),
    Color(0xFFe17055),
    Color(0xFF00b894),
  ];

  @override
  void initState() {
    super.initState();

    categories = CategoriesApi().fetchCategories();
    initData();
  }

  initData() async {
    Map<String, double> data = { };
    colorList = [];
    final costs = await DBProvider.db.getCosts(true);
    costs.forEach((element) {
      data[element.name] = element.sum.toDouble();
      final category = categories.firstWhere((cat) => cat.name == element.name);
      colorList.add(category.color);
    });

    setState(() {
      dataMap = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PieChart(
        key: ValueKey(0),
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
            ? 300
            : MediaQuery.of(context).size.width / 3.2,
        colorList: colorList.isNotEmpty ? colorList : defaultColorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        centerText: 'Amount',
        legendOptions: const LegendOptions(
          showLegends: false,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: const ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: false,
        ),
        // ringStrokeWidth: _ringStrokeWidth!,
        // emptyColor: Colors.grey,
        // gradientList: _showGradientColors ? gradientList : null,
        // emptyColorGradient: [
        //   Color(0xff6c5ce7),
        //   Colors.blue,
        // ],
      ),
    );
  }
}
