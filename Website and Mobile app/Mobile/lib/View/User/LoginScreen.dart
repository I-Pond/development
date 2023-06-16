
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/LoginController.dart';
import 'package:myipond/Utils/Routes.dart';
import '../../Widget/bezierContainer.dart';

class LoginScreen extends StatelessWidget {

  final height = Get.height;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoginController>(builder: (data){
      return Scaffold(
          body: SizedBox(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: const BezierContainer()),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        const SizedBox(height: 50),
                        _emailPasswordWidget(),
                        const SizedBox(height: 20),
                        _submitButton(),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () async {
                            ArtDialogResponse? response = await ArtSweetAlert.show(
                              barrierDismissible: false,
                              context: context,
                              artDialogArgs: ArtDialogArgs(
                                  denyButtonText: "Cancel",
                                  title: "Forgot Password",
                                  text: "Masukkan email anda",
                                  confirmButtonText: "Yes",
                                  type: ArtSweetAlertType.info,
                                  customColumns: [
                                    _entryField("Email", data.emailController ),
                                    const SizedBox(height: 15,)
                                  ]
                              ),
                            );

                            if(response==null) {
                              return;
                            }

                            if(response.isTapConfirmButton) {
                              bool cek = await data.requestOTPResetProses();
                              if(!cek){
                                return;
                              }
                              ArtSweetAlert.show(
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                      type: ArtSweetAlertType.success,
                                      title: "Sukses",
                                      text: "Berhasil Request email, silahkan cek inbox anda"
                                  )
                              );
                              await Future.delayed(const Duration(seconds: 2));
                              Get.back();
                              Get.toNamed(Routes().forgotpass);
                              return;
                            }

                            if(response.isTapDenyButton){
                              return;
                            }

                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.centerRight,
                            child: const Text('Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        _divider(),
                        SizedBox(height: height * .055),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }

  Widget _entryField(String title, TextEditingController textcontroller, {bool isPassword = false, }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: textcontroller,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () async {

          await Get.find<LoginController>().loginProses(Get.context!);

        },
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.lightBlue, Colors.lightBlueAccent])),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes().register);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => register()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'My-',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'i',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Pond',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return GetBuilder<LoginController>(builder: (data){
      return Column(
        children: <Widget>[
          _entryField("Email", data.emailController ),
          _entryField("Password", data.passController ,isPassword: true),
        ],
      );
    });
  }


}
