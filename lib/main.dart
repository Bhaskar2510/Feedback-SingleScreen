import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController problemBox = TextEditingController();

  final db = FirebaseFirestore.instance;

  List _listItem = ["Category 1", "Category 2", "Category 3", "Category 4"];
  List _listItem1 = [
    "Sub Category 1",
    "Sub Category 2",
    "Sub Category 3",
    "Sub Category 4"
  ];
  List _listItem2 = ["CRIS", "ADMINISTRATION", "ZONE", "DEPARTMENT"];

  String dropdownValue;
  String holder = '';

  void getDropDownItem() async {
    setState(() {
      holder = dropdownValue;
    });
  }

  String dropdownValue1;
  String holder1 = '';

  void getDropDownItem1() async {
    setState(() {
      holder1 = dropdownValue1;
    });
  }

  String dropdownValue2;
  String holder2 = '';

  void getDropDownItem2() async {
    setState(() {
      holder2 = dropdownValue2;
    });
  }

  bool autoValidate = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Feedback"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.home),
          ),
        ),
        body: Container(
            child: Center(
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(child: Text("CATEGORY")),
                        Flexible(
                            child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(width: 30),
                        Flexible(
                            child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          hint: Text("Select"),
                          value: dropdownValue,
                          validator: (value) =>
                              value == null ? "Please select a value" : null,
                          items: _listItem
                              .map<DropdownMenuItem<String>>((valueItem) {
                            return DropdownMenuItem<String>(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(child: Text("SUB-CATEGORY")),
                        Flexible(
                            child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(width: 30),
                        Flexible(
                            child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          hint: Text("Select"),
                          value: dropdownValue1,
                          validator: (value) =>
                              value == null ? "Please select a value" : null,
                          items: _listItem1
                              .map<DropdownMenuItem<String>>((valueItem1) {
                            return DropdownMenuItem<String>(
                              value: valueItem1,
                              child: Text(valueItem1),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue1 = value;
                            });
                          },
                        )),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(child: Text("MARKED TO")),
                        Flexible(
                            child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(width: 30),
                        Flexible(
                            child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          hint: Text("Select"),
                          value: dropdownValue2,
                          validator: (value) =>
                              value == null ? "Please select a value" : null,
                          items: _listItem2
                              .map<DropdownMenuItem<String>>((valueItem2) {
                            return DropdownMenuItem<String>(
                              value: valueItem2,
                              child: Text(valueItem2),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue2 = value;
                            });
                          },
                        )),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(70, 00, 70, 00),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Description is required";
                              }
                              return null;
                            },
                            controller: problemBox,
                            decoration: InputDecoration(
                              hintText: "Describe your problem here.",
                            ),
                            maxLength: 1000,
                            maxLines: 5,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    ButtonTheme(
                      child: ElevatedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Submitting Data')));
                            db.collection("COLLECTION").add(
                              {
                                "CATEGORY": dropdownValue,
                                "SUB-CATEGORY": dropdownValue1,
                                "MARKED TO": dropdownValue2,
                                "PROBLEM": problemBox.text,
                              },
                            );
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                            setState(() {
                              problemBox.clear();
                              dropdownValue = null;
                              dropdownValue1 = null;
                              dropdownValue2 = null;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        )));
  }
}
