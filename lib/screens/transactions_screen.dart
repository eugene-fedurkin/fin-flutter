import 'package:flutter/material.dart';
import 'package:organizer/widgets/donut_chart.dart';
import 'package:organizer/widgets/transaction-list.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Transactions'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          const DonutChart(),
          const SizedBox(height: 10,),
          Expanded(
            child: TransactionList()
          ),
        ],
      ),
    );
  }
}
