import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungappfriend/models/user_model.dart';
import 'package:ungappfriend/states/create_account.dart';
import 'package:ungappfriend/utility/my_constant.dart';
import 'package:ungappfriend/utility/my_dialog.dart';
import 'package:ungappfriend/widgets/show_button.dart';
import 'package:ungappfriend/widgets/show_form.dart';
import 'package:ungappfriend/widgets/show_image.dart';
import 'package:ungappfriend/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constrants) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Container(
            decoration: MyConstant().basicBox(),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  logoAndTitle(constrants),
                  userForm(constrants),
                  passwordForm(constrants),
                  newButton(context: context),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Container newButton({required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShowButton(
            label: 'SingIn',
            pressFunc: () {
              if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
                MyDialog(context: context).normalDialog(
                    title: 'Have Space', subTitle: 'Please Fill All Blank');
              } else {
                processAuthen();
              }
            },
          ),
          const SizedBox(
            width: 4,
          ),
          ShowButton(
            label: 'SignUp',
            pressFunc: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateAccount(),
                  ));
            },
          ),
        ],
      ),
    );
  }

  Container passwordForm(BoxConstraints constrants) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: constrants.maxWidth * 0.55,
      child: ShowForm(
        iconData: Icons.lock_outline,
        obsceu: true,
        hint: 'Password:',
        changeFunc: (String string) {
          password = string.trim();
        },
      ),
    );
  }

  Container userForm(BoxConstraints constrants) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: constrants.maxWidth * 0.55,
      child: ShowForm(
        iconData: Icons.person_outline,
        hint: 'User:',
        changeFunc: (String string) {
          user = string.trim();
        },
      ),
    );
  }

  SizedBox logoAndTitle(BoxConstraints constrants) {
    return SizedBox(
      width: constrants.maxWidth * 0.6,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: constrants.maxWidth * 0.12,
            child: const ShowImage(),
          ),
          ShowText(
            text: 'Login:',
            textStyle: MyConstant().h1Style(),
          ),
        ],
      ),
    );
  }

  Future<void> processAuthen() async {
    String path =
        'https://www.androidthai.in.th/fluttertraining/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) {
      if (value.toString() == 'null') {
        MyDialog(context: context).normalDialog(
            title: 'User False', subTitle: 'No $user in my Database');
      } else {
        print('value ==> $value');

        var result = json.decode(value.data);
        print('result ==> $result');

        for (var element in result) {
          UserModel userModel = UserModel.fromMap(element);

          print(
              'password ==> $password, passwordModel ==> ${userModel.password}');

          if (password == userModel.password) {
            //password true
            processSaveUser(userModel: userModel);
          } else {
            //password false
            MyDialog(context: context).normalDialog(
                title: 'Password False',
                subTitle: 'Please Try Again Password False');
          }
        }
      }
    });
  }

  Future<void> processSaveUser({required UserModel userModel}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('id', userModel.id);
    sharedPreferences.setString('name', userModel.name);
    sharedPreferences.setString('avatar', userModel.avatar);
    sharedPreferences.setString('token', userModel.token);

    Navigator.pushNamedAndRemoveUntil(
        context, '/listAllMember', (route) => false);
  }
}
