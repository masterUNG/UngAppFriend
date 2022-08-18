import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungappfriend/utility/my_dialog.dart';
import 'package:ungappfriend/widgets/show_button.dart';
import 'package:ungappfriend/widgets/show_form.dart';
import 'package:ungappfriend/widgets/show_icon_button.dart';
import 'package:ungappfriend/widgets/show_image.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  File? file;
  String? name, user, password, avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: ListView(
            children: [
              newImage(constraints),
              createCenter(constraints,
                  widget: ShowForm(
                    hint: 'Name:',
                    changeFunc: (p0) {
                      name = p0.trim();
                    },
                  )),
              createCenter(constraints,
                  widget: ShowForm(
                    hint: 'User:',
                    changeFunc: (p0) {
                      user = p0.trim();
                    },
                  )),
              createCenter(constraints,
                  widget: ShowForm(
                    hint: 'Password:',
                    changeFunc: (p0) {
                      password = p0.trim();
                    },
                  )),
              createCenter(constraints,
                  widget: ShowButton(
                    label: 'Create Account',
                    pressFunc: () {
                      if (file == null) {
                        //NOt Take Photo
                        MyDialog(context: context).normalDialog(
                            title: 'No Avatat?',
                            subTitle:
                                'Please Take Photo by Tap Camera or Gallery');
                      } else if ((name?.isEmpty ?? true) ||
                          (user?.isEmpty ?? true) ||
                          (password?.isEmpty ?? true)) {
                        MyDialog(context: context).normalDialog(
                            title: 'Have Space ?',
                            subTitle: 'Please Fill Every Blank');
                      } else {
                        processCheckUser();
                      }
                    },
                  ))
            ],
          ),
        );
      }),
    );
  }

  Row createCenter(BoxConstraints constraints, {required Widget widget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: widget,
        ),
      ],
    );
  }

  Row newImage(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          width: constraints.maxWidth * 0.6,
          height: constraints.maxWidth * 0.6,
          child: Stack(
            children: [
              file == null
                  ? const ShowImage(
                      path: 'images/image.png',
                    )
                  : CircleAvatar(
                      radius: constraints.maxWidth * 0.3,
                      backgroundImage: FileImage(file!),
                    ),
              Positioned(
                bottom: 0,
                left: 0,
                child: ShowIconButton(
                  iconData: Icons.add_a_photo,
                  pressFunc: () {
                    processTakePhoto(source: ImageSource.camera);
                  },
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: ShowIconButton(
                  iconData: Icons.add_photo_alternate,
                  pressFunc: () {
                    processTakePhoto(source: ImageSource.gallery);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> processTakePhoto({required ImageSource source}) async {
    var result = await ImagePicker().pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (result != null) {
      file = File(result.path);
      setState(() {});
    }
  }

  Future<void> processCheckUser() async {
    String path =
        'https://www.androidthai.in.th/fluttertraining/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) {
      print('value ==> $value');

      if (value.toString() == 'null') {
        // User True
        processUploadImageToServer();
      } else {
        // User False
        MyDialog(context: context).normalDialog(
            title: 'User ซ้ำ ?',
            subTitle: 'กรุณาเปลี่ยน User ใหม่ User นี่ ซ้ำ');
      }
    });
  }

  Future<void> processUploadImageToServer() async {
    String nameImage = '$user.jpg';
    String path =
        'https://www.androidthai.in.th/fluttertraining/saveFileUng.php';

    Map<String, dynamic> map = {};
    map['file'] = await MultipartFile.fromFile(
      file!.path,
      filename: nameImage,
    );
    FormData data = FormData.fromMap(map);
    await Dio().post(path, data: data).then((value) {
      print('value == $value');
      processInsertDataToMySQL(nameImage: nameImage);
    });
  }

  Future<void> processInsertDataToMySQL({required String nameImage}) async {
    avatar = 'https://www.androidthai.in.th/fluttertraining/ung/$nameImage';

    String path =
        'https://www.androidthai.in.th/fluttertraining/insertDataUng.php?isAdd=true&name=$name&user=$user&password=$password&avatar=$avatar';

    await Dio().get(path).then((value) {
      Navigator.pop(context);
    });
  }
}
