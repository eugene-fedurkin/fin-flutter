import 'package:flutter/material.dart';

class AmountInput extends StatelessWidget {
  final TextEditingController controller;

  const AmountInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.center,
            width: 150,
            child: TextFormField(
                controller: controller,
                autofocus: true,
                cursorColor: Colors.green,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  contentPadding: EdgeInsets.only(left: 15, right: 15),
                ))),
        const Text(
          'BYN',
          style: TextStyle(fontSize: 18, color: Colors.green),
        )
      ],
    ));
  }
}
