// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungappfriend/utility/my_constant.dart';

class ShowButton extends StatelessWidget {
  final String label;
  final Function() pressFunc;
  const ShowButton({
    Key? key,
    required this.label,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: MyConstant.bgColor),
      onPressed: pressFunc,
      child: Text(label),
    );
  }
}
