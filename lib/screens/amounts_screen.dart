import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organizer/widgets/cost-list.dart';

class Amounts extends StatelessWidget {
  const Amounts({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Balance')
      ),
      body: Container(
        child: Wrap(
          children: [
            Column(
              children: [
                CostList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}