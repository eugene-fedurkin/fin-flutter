import 'package:flutter/material.dart';
import 'package:organizer/widgets/amount_chart.dart';
import 'package:organizer/widgets/cost-list.dart';

class Amounts extends StatelessWidget {
  const Amounts({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Total'),
        centerTitle: true,
      ),
      body: Wrap(
        children: [
          Column(
            children: const [
              AmountChart(),
              CostList(sum: true,)
            ],
          ),
        ],
      ),
    );
  }
}