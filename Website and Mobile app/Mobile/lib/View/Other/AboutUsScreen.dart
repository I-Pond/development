import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/OtherController.dart';

class AboutUsScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<OtherController>(builder: (data){
      return Scaffold(
          appBar: AppBar(
            title: Text(data.title),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(75),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  offset: Offset(10, 15),
                                  color: Color(0x22000000),
                                  blurRadius: 20.0)
                            ],
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/999/UP1018-CUSA00133_00-AV00000000000015/1553561653000/image?w=256&h=256&bg_color=000000&opacity=100&_version=00_09_000'))),
                      ),

                    ],
                  ),

                  const SizedBox(height: 40,),
                  ListTile(
                    // title: Text("Kontak Kami"),
                    subtitle: Text(data.isi),
                  ),
                  const SizedBox(height: 10,),
                  const ListTile(
                    title: Text("Author"),
                    // subtitle: Text("0882213155"),
                  ),
                  const ListTile(
                    title: Text("Orang 1 ...."),
                    subtitle: Text("Web"),
                  ),
                  const SizedBox(height: 10,),
                  const ListTile(
                    title: Text("Orang 2 ...."),
                    subtitle: Text("Mobile"),
                  ),
                  const SizedBox(height: 10,),
                  const ListTile(
                    title: Text("Orang 3 ...."),
                    subtitle: Text("Dokumentasi"),
                  ),
                  const SizedBox(height: 10,),
                  const ListTile(
                    title: Text("Kontak Kami"),
                    subtitle: Text("0882213155"),
                  ),

                ],
              ),
            )
          )
      );
    });
  }

}