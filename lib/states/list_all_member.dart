import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungappfriend/utility/my_constant.dart';
import 'package:ungappfriend/utility/my_dialog.dart';
import 'package:ungappfriend/widgets/show_icon_button.dart';
import 'package:ungappfriend/widgets/show_text.dart';

class ListAllMember extends StatelessWidget {
  const ListAllMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          ShowIconButton(
            iconData: Icons.exit_to_app,
            pressFunc: () {
              MyDialog(context: context).normalDialog(
                  label: 'SignOut',
                  pressFunc: () {
                    processSignOut(context: context);
                  },
                  title: 'SignOut ?',
                  subTitle: 'Please Confirm SignOut');
            },
          )
        ],
        centerTitle: true,
        title: ShowText(
          text: 'List All Member',
          textStyle: MyConstant().h2Style(),
        ),
      ),
    );
  }

  Future<void> processSignOut({required BuildContext context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/authen', (route) => false);
    });
  }
}
