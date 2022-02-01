import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmountInput extends StatelessWidget {
  final TextEditingController controller;

  const AmountInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Wrap(
      children: [
        TextFormField(
          controller: controller,
          autofocus: true,
        )
      ],
    ));
  }
}
