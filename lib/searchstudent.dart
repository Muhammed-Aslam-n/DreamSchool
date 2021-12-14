import 'package:flutter/material.dart';
import 'package:todofromnet/databasehandler.dart';
import 'databasehandler.dart';
import 'database.dart';
import 'fulldetails.dart';
import 'home.dart';


class SearchStudent extends StatefulWidget {
  const SearchStudent({Key? key}) : super(key: key);

  @override
  _SeachStudentState createState() => _SeachStudentState();
}

var keyword = '';
var selectedId;

class _SeachStudentState extends State<SearchStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Enter Name'),
                    onChanged: (value) {
                      keyword = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: DatabaseHelper.instance.searchStudents(keyword),
                    builder: (context, AsyncSnapshot<List<Grocery>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading...'));
                      }
                      return snapshot.data!.isEmpty
                          ? const Center(child: Text('No Student in List.'))
                          : ListView(
                              children: snapshot.data!.map(
                                (grocery) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: selectedId == grocery.id
                                            ? Colors.white70
                                            : Colors.white,
                                        child: ListTile(
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(top: 8.0,left: 8,bottom: 8),
                                            child: Text("${grocery.rollnum}"),
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Text(grocery.name),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              DatabaseHelper.instance.idd =
                                                  ((grocery.id)!);
                                              DatabaseHelper.instance.edtid = null;
                                              print(
                                                  "Shortlist idd is ${DatabaseHelper.instance.idd}\tGroceryId is ${grocery.id}");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FullDetails()));
                                            });
                                          },
                                          onLongPress: () {
                                            setState(
                                              () {
                                                DatabaseHelper.instance
                                                    .remove(grocery.id!);
                                                // DatabaseHelper.instance.idd++;
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
