import 'package:flutter/material.dart';
import 'package:ungappfriend/states/create_account.dart';
import 'package:ungappfriend/utility/my_constant.dart';
import 'package:ungappfriend/widgets/show_button.dart';
import 'package:ungappfriend/widgets/show_form.dart';
import 'package:ungappfriend/widgets/show_image.dart';
import 'package:ungappfriend/widgets/show_text.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

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
            pressFunc: () {},
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
        changeFunc: (String string) {},
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
        changeFunc: (String string) {},
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
}
