import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myipond/Controller/DashboardController.dart';
import 'package:myipond/Model/News.dart';
import 'package:myipond/Widget/customWidget.dart';

import '../../Widget/CustomAppBar.dart';

class AdminNewsScreen extends StatefulWidget {
  @override
  createState() => _AdminNewsScreen();
}

class _AdminNewsScreen extends State<AdminNewsScreen> {

  GlobalKey<ScaffoldState>? key;
  var dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    // TODO: implement initState
    key = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    key = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<DashboardController>(builder: (data){
      return Scaffold(
          // backgroundColor: Colors.grey[400],
          key: key,
          drawer: drawerWeb(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: (){
              customNewsWidget("", "", "", "");
            },
          ),
          body: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  // height: 258,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 10,
                      right: 30.0),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff669df4), Color(0xff4e80f3)]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: CustomAppBar(context, key!),
                ),
                const SizedBox(height: 30,),
                Container(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12
                  ),
                  child: Row(
                    children: [

                      Expanded(
                        flex: 6,
                          child:Column(
                            children: [

                              const Text("List berita",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                                ),
                              ),

                              GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                primary: false,
                                shrinkWrap: true,
                                crossAxisCount:  4,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 5/2,
                                children: List.generate(data.listNews.length, (index) {
                                  NewsElement news = data.listNews[index];
                                  return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent,
                                          border: Border.all(
                                            color: Colors.lightBlueAccent,
                                          ),
                                          borderRadius: const BorderRadius.all(Radius.circular(8))
                                      ),
                                      child:Row(
                                        children: [

                                          Expanded(
                                            flex: 1,
                                            child: Image.network(news.gambarfix)
                                          ),

                                          Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(news.name,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        // color: textColor
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      data.formatterJam.format(news.createdAt) + "\n"
                                                          + data.formatter2.format(news.createdAt),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.normal,
                                                        // color: textColor
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              )
                                          ),

                                          Expanded(
                                            flex: 1,
                                            child:Column(
                                              children: [
                                                IconButton(
                                                  onPressed: (){
                                                    customNewsWidget(news.id, news.name, news.content, news.gambarfix);
                                                  },
                                                  icon: const Icon(Icons.edit)
                                                ),

                                                IconButton(
                                                    onPressed: (){
                                                      data.deleteNews(Get.context!, news.id);
                                                    },
                                                    icon: const Icon(Icons.delete)
                                                ),
                                              ],
                                            )
                                          ),

                                        ],
                                      )
                                    );
                                  })
                                ),

                             ],
                            )
                        ),

                      ],
                    )
                ),

                Container(height: 200,)



              ])
          )
      );
    });
  }

  customNewsWidget(String id, String name, String content, String image) async {
    dashboardController.imageFile = null;
    dashboardController.judulNewsController.text = name;
    dashboardController.isiNewsController.text = content;

    ArtDialogResponse? response = await ArtSweetAlert.show(
        barrierDismissible: false,
        context: context,
        artDialogArgs: ArtDialogArgs(
          denyButtonText: "Cancel",
          title: (id.isEmpty)?"Buat Berita baru":"Edit Berita",
          // text: "",
          confirmButtonText: "Save",
          type:ArtSweetAlertType.info,
          customColumns: [
            GetBuilder<DashboardController>(builder: (data){
              return Column(
                children: [
                  const SizedBox(height: 40,),

                  InkWell(
                    onTap: () async {
                      await data.pickImage();
                    },
                    child: SizedBox(
                        height: 200,
                        child: (data.imageFile != null)?
                        data.previewImages()
                        :(image.isNotEmpty)? Image.network(image)
                        :Image.asset("assets/images/empty_image.jpeg")
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Container(
                    padding: const EdgeInsets.fromLTRB(10,2,10,2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red)
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: "Judul berita",
                      ),
                      controller: data.judulNewsController,
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Container(
                    height: 300,
                    padding: const EdgeInsets.fromLTRB(10,2,10,2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red)
                    ),
                    child: TextField(
                      maxLines: 15,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: "Isi Berita",
                      ),
                      controller: data.isiNewsController,
                    ),
                  ),

                  const SizedBox(height: 30),

                ],
              );
            }),

          ]
        )
    );

    if(response==null) {
      return;
    }

    if(response.isTapConfirmButton) {
      if(id.isEmpty){
        await dashboardController.uploadNews(context);
      }
      if(id.isNotEmpty){
        await dashboardController.editNews(context, id);
      }
      return;
    }

  }

}