import 'package:flutter/material.dart';
import 'package:organizer/widgets/donut_chart.dart';
import 'package:organizer/widgets/total-list.dart';

class Amounts extends StatelessWidget {
  const Amounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text('Total'),
          centerTitle: true,
        ),
        body: Column(
          children: const [DonutChart(), Expanded(child: TotalList())],
        ));
  }
}
