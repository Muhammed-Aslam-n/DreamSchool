import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todofromnet/shortdetails.dart';
import 'databasehandler.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'database.dart';
import 'home.dart';

class EditDetails extends StatefulWidget {
  const EditDetails({Key? key}) : super(key: key);

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  int? selectedId;
  var editID=null;

  var eId,
      ename = "Name",
      eage = "Age",
      erollnum = "Roll Number",
      emobile = "Mobile Number";
  bool isValue = false;

  @override
  void initState() {
    editID = DatabaseHelper.instance.edtid;
    checkId();
    debugPrint("Passed Id in EditDetails InitState is  ${editID}");
  }

  void checkId() async {
    if (editID != null) {
      List<Grocery> g = await DatabaseHelper.instance.getGroceries();
      debugPrint("Passed Id inside CheckFunction is $editID");
      setState(() {
        print("${g.map((e) {
          if (e.id == editID) {
            debugPrint("Item Found");
            eId = e.id;
            ename = e.name;
            erollnum = e.rollnum;
            eage = e.age;
            emobile = e.mobile;
          }
          cname.text = ename;
          cage.text = eage;
          cmobile.text = emobile;
          creg.text = erollnum;
        })}");
      }
      );
    }
  }
  var cname = TextEditingController();
  var cage = TextEditingController();
  var cmobile = TextEditingController();
  var cimage = TextEditingController();
  var creg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future showSnackbar() async {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Fields Cannot Be Empty',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
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
      body: WillPopScope(
        onWillPop: () async {
          if(DatabaseHelper.instance.isClickingAfterEditorAdd == true){
            Navigator.of(context).pushReplacementNamed('/shortDetails');
            DatabaseHelper.instance.isClickingAfterEditorAdd = false;
            debugPrint("The IsClicking value in editdetails - if  once after true is ${DatabaseHelper.instance.isClickingAfterEditorAdd}");
            return true;
          }
          else{
            debugPrint("Is click in Else is ${DatabaseHelper.instance.isClickingAfterEditorAdd}");
            Navigator.of(context).popUntil((route) => route.isFirst);
            return true;
          }

        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: cname,
                    keyboardType: TextInputType.text,
                    validator: Validators.compose([
                      Validators.required("This Field is Required"),
                      Validators.minLength(
                          5, "Name must be atleast 5 Characters"),
                    ]),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-z.A-Z ]'))
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Name',
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 9, 87, 102),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: cage,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9 ]'))
                    ],
                    validator: Validators.compose([
                      Validators.required("Age is Required"),
                      Validators.maxLength(2, "Invalid Age"),
                    ]),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.accessibility),
                      labelText: 'Age',
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 9, 87, 102),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: creg,
                    keyboardType: TextInputType.number,
                    validator: Validators.compose([
                      Validators.required("This is Field is Required"),
                      Validators.maxLength(10, "Invalid Register Number"),
                      Validators.minLength(5, "Invalid Register Number"),
                    ]),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9 ]'))
                    ],
                    decoration: InputDecoration(
                      icon: const Icon(Icons.paste),
                      labelText: 'Roll Number',
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 9, 87, 102),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: cmobile,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),
                    ],
                    validator: Validators.compose([
                      Validators.required("This is Field is Required"),
                      Validators.maxLength(10, "Maximum 10 Digits"),
                      Validators.minLength(10, "Minimum 10 Digits")
                    ]),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.phone),
                      labelText: 'Contact Number',
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 9, 87, 102),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    child: OutlinedButton(
                      onPressed: () async {
                        debugPrint(cmobile.text);
                        // debugPrint(e)
                        if (cname.text == '' ||
                            cmobile.text == '' ||
                            creg.text == '' ||
                            cage.text == '') {
                          return showSnackbar();
                        } else {
                          editID != null
                              ? await DatabaseHelper.instance.update(
                                  Grocery(
                                      id: eId,
                                      name: cname.text,
                                      mobile: cmobile.text,
                                      age: cage.text,
                                      rollnum: creg.text),
                                )
                              : await DatabaseHelper.instance.add(
                                  Grocery(
                                      name: cname.text,
                                      mobile: cmobile.text,
                                      age: cage.text,
                                      rollnum: creg.text),
                                );
                        }
                        setState(() {
                          DatabaseHelper.instance.idd = null;
                          DatabaseHelper.instance.edtid =null;
                          selectedId = null;
                          DatabaseHelper.instance.isClickingAfterEditorAdd = true;
                        });
                        DatabaseHelper.instance.edtid = null;
                        DatabaseHelper.instance.isClickingAfterEditorAdd = true;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShortDetails()));
                      },
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 9, 87, 102), width: 1.0),
                          minimumSize: Size(230, 50)),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            color: Color.fromARGB(255, 9, 87, 102)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
