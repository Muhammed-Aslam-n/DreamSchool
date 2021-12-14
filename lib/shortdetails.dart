import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todofromnet/database.dart';
import 'databasehandler.dart';
import 'fulldetails.dart';
import 'home.dart';

class ShortDetails extends StatefulWidget {
  const ShortDetails({Key? key}) : super(key: key);

  @override
  _ShortDetailsState createState() => _ShortDetailsState();
}

class _ShortDetailsState extends State<ShortDetails> {
  int? selectedId;
  final textController = TextEditingController();
  var isComingAfter;
  @override
  void initState() {
    DatabaseHelper.instance.reset();
    debugPrint("reloaded");
    super.initState();
    isComingAfter = DatabaseHelper.instance.isClickingAfterEditorAdd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/AppbarICon.png'),
        centerTitle: true,
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
              children: [
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
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Muhammed Aslam n",style: TextStyle(fontSize: 22),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).popUntil((route) => route.isFirst);
          return true;
        },
        child: Center(
          child: FutureBuilder<List<Grocery>>(
            future: DatabaseHelper.instance.getGroceries(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Grocery>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: const Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Students Added yet.'))
                  : ListView(
                      children: snapshot.data!.map(
                        (grocery) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8,16,8,8),
                              child: Card(
                                color: selectedId == grocery.id
                                    ? Colors.white70
                                    : Colors.white,
                                child: ListTile(
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Roll Num : ${grocery.rollnum}",style: TextStyle(fontSize: 13,color: Colors.blueAccent)),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text("${grocery.name}",style: TextStyle(fontSize: 20,color: Colors.redAccent)),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      DatabaseHelper.instance.idd = ((grocery.id)!);
                                      print(
                                          "Shortlist idd is ${DatabaseHelper.instance.idd}\tGroceryId is ${grocery.id}");
                                      Navigator.pushNamed(context, '/fullDetails');
                                    });
                                  },
                                  onLongPress: () {
                                    setState(
                                      () {
                                        showDialog<String>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('Delete'),
                                            content: const Text('Are you Sure you want to Remove this Student ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    DatabaseHelper.instance
                                                        .remove(grocery.id!);
                                                    Navigator.pop(context, 'Cancel');
                                                  });
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );


                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.pushNamed(context, '/editDetails');
        },
      ),
    );
  }
}
