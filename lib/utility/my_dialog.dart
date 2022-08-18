// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungappfriend/utility/my_constant.dart';
import 'package:ungappfriend/widgets/show_image.dart';
import 'package:ungappfriend/widgets/show_text.dart';
import 'package:ungappfriend/widgets/show_text_button.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  void normalDialog({
    required String title,
    required String subTitle,
    String? label,
    Function()? pressFunc,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const SizedBox(
            width: 80,
            child: ShowImage(),
          ),
          title: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(text: subTitle),
        ),
        actions: [
          label == null
              ? const SizedBox()
              : ShowTextButton(label: label, pressFunc: pressFunc!),
          ShowTextButton(
            label: label == null ? 'OK' : 'Cancel',
            pressFunc: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
