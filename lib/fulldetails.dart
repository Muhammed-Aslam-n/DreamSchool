import 'package:flutter/material.dart';
import 'package:todofromnet/shortdetails.dart';
import 'database.dart';
import 'databasehandler.dart';
import 'home.dart';

class FullDetails extends StatefulWidget {
  const FullDetails({Key? key}) : super(key: key);

  @override
  _FullDetailsState createState() => _FullDetailsState();
}

var id, name, age, rollnum, mobile, passedId;

@override
class _FullDetailsState extends State<FullDetails> {
  @override
  void initState() {
    passedId = DatabaseHelper.instance.idd;
    refreshContact(passedId);
    print("Passed Id (tapping id)  in fullDetails is  $passedId");
    super.initState();
  }

  refreshContact(var idd) async {
    List<Grocery> g = await DatabaseHelper.instance.getGroceries();
    setState(
      () {
        DatabaseHelper.instance.reset();
        print("${g.map(
          (e) {
            if (e.id == passedId) {
              debugPrint("Item Found");
              id = e.id;
              name = e.name;
              rollnum = e.rollnum;
              age = e.age;
              mobile = e.mobile;
            }
          },
        )}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          Navigator.of(context).pop();
          // Navigator.pop(context);
          return true;
        },
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(170, 255, 91, 107),
                Color.fromARGB(255, 251, 91, 107)
              ])),
          child: Container(
            margin: const EdgeInsets.only(top: 120, left: 30, right: 30, bottom: 130),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            // alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      ' ${name}',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: const Icon(Icons.accessibility),
                    title: Text(
                      ' ${age}',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: Icon(Icons.margin),
                    title: Text(
                      ' ${rollnum}',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      ' ${mobile}',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Text(''),
                  TextButton(
                    onPressed: () {
                      DatabaseHelper.instance.edtid = id;
                      DatabaseHelper.instance.isClickingAfterEditorAdd = true;
                      Navigator.pushNamed(context, '/editDetails');
                      debugPrint("Id that passes from FulDetails to Edit is : $passedId");
                    },
                    child: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
