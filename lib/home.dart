import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todofromnet/database.dart';
import 'package:todofromnet/databasehandler.dart';
import 'editdetail.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class Home extends StatefulWidget {
  late List<Grocery> notes;

  @override
  _HomeState createState() => _HomeState();
}

contentBox({heading, desc, color}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: color,
    ),
    margin: EdgeInsets.all(20),
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          heading,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 25, 10, 15),
          child: Text(
            desc,
            style: TextStyle(
                letterSpacing: 2,
                wordSpacing: 1.2,
                color: Color.fromARGB(170, 196, 44, 59)),
          ),
        )
      ],
    ),
  );
}

class _HomeState extends State<Home> {
  final List<String> imageList = [
    "images/school/School1.jfif",
    "images/school/School2.jfif",
    "images/school/School3.jfif",
    "images/school/School4.jfif",
    "images/school/School5.jfif",
  ];
  DateTime timeBackPressed = DateTime.now();
  var isComing;
  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop:() async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExisting = difference >= Duration(seconds: 2);
          timeBackPressed = DateTime.now();
          if(isExisting){
            final message = "Press Again To Exit";
            Fluttertoast.showToast(msg: message,fontSize: 15);
            return false;
          }
          else{
            Fluttertoast.cancel();
            return true;
          }
        }
        ,
        child: Scaffold(
        appBar: AppBar(
          leading: Image.asset('images/AppbarICon.png'),
          backgroundColor: Colors.blueAccent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'DreamSchool',
                style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w600,
                    fontSize: 26),
              ),
              Text(
                'Where Wishes Comes True',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: const [
                   DrawerHeader(
                     decoration: BoxDecoration(
                       color: Colors.blue,
                       image: DecorationImage(
                           image: AssetImage("images/student/s4.jfif"),
                           fit: BoxFit.cover),
                     ),
                     child: Text(''),
                   ),
                   Padding(
                     padding: EdgeInsets.all(16.0),
                     child: Text("Muhammed Aslam n",style: TextStyle(fontSize: 22),),
                   ),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 16.0),
                     child: Text("Ass.Prof Computer Science",style: TextStyle(fontSize: 14),),
                   )
                 ],
               ),
              SizedBox(
                height: 30,
              ),
              Text("Utilities",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.blueAccent,letterSpacing: 2),),
              Divider(
                color: Colors.blueAccent,thickness: 1.3,
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.wysiwyg_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text("View Students"),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/shortDetails');
                  setState(() {
                    DatabaseHelper.instance.isClickingAfterEditorAdd = false;
                  });
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.search_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Search Students"),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/searchStudents');
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(Icons.add),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Add Students"),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/editDetails');
                },
              ),
            ],
          ),
        ),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width / 4.2,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(25.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  ),
                  items: imageList
                      .map((e) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image.asset(
                                  e,
                                  width: 1000,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              contentBox(
                color: Colors.white,
                heading: 'How we Differ',
                desc: descriptionText,
              ),
              contentBox(
                color: Colors.white,
                heading: 'Vision',
                desc: descriptionText,
              ),
              contentBox(
                color: Colors.white,
                heading: 'Stories',
                desc: descriptionText,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 35),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
    ),
      );
  }

  var descriptionText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged";
}
