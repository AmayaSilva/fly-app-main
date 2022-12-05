import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fly_app/screens/results.dart';
import 'package:fly_app/widgets/button_widget.dart';

class TableView extends StatefulWidget {
  static const routeName = '/questionnaire2';

  const TableView({Key? key}) : super(key: key);

  @override
  //_TableViewState createState() => _TableViewState();
  State<StatefulWidget> createState() {
    return _TableViewState();
  }
}

class _TableViewState extends State<TableView> {
  List rowHeaders = [];
  List columnHeaders = [];
  Map selected = {};

  @override
  void initState() {
    super.initState();
    saveHeaders(); //Iterate and store all Row and column Headers
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void _submit() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    print(uid);
    //sumSelected();
    addScoreDetails(uid, sumSelected());
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ResultsScreen()));
  }

  num sumSelected() {
    num sum = 0;
    for (int i = 0; i < selected.length; i++) {
      sum += selected[rowHeaders[i]];
    }
    return sum;
  }

  Future addScoreDetails(uid, num sum) async {
    await FirebaseFirestore.instance
        .collection('results')
        //.add({'atco_email': email, 'atco_password': password});
        .doc(uid)
        .set({
      // "atco_id": _user?.atcid,
      // "atco_email": _user?.email,
      //"atco_id": UserData.atcid,
      "uid": uid,
      "que_two_score": sum,
    }, SetOptions(merge: true));
  }

  saveHeaders() {
    //Saving All Headers
    columnHeaders.addAll(["0", "1", "2", "3"]);
    rowHeaders.addAll([
      "Sitting and reading",
      "Watching TV",
      "Sitting inactive in a public place",
      "Being a passenger in a car for an hour",
      "Lying down in the afternoon",
      "Sitting and talking to someone",
      "Sitting quietly after lunch (no alcohol)",
      "Stopping for a few minutes in traffic while driving"
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              //title: const Text("TableView"),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 02",
                  ),
                  Text(
                    "Answer all the questions",
                    style: Theme.of(context).textTheme.bodyText2!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            body: OrientationBuilder(builder: (context, orientation) {
              return Center(
                  child: SingleChildScrollView(
                scrollDirection: orientation ==
                        Orientation
                            .portrait //Handle Scroll when Orientation is changed
                    ? Axis.horizontal
                    : Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.blueGrey[200],
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      alignment: FractionalOffset.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //headers
                          Container(
                            margin: const EdgeInsets.all(0.0),
                            child: Row(children: [
                              Container(
                                alignment: FractionalOffset.center,
                                width: 140.0,
                                margin: const EdgeInsets.all(0.0),
                                padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 3.0,
                                    left: 3.0),
                                child: Text(
                                  //Leave an empty text in Row(0) and Column (0)
                                  "",
                                  style: TextStyle(color: Colors.grey[800]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ...columnHeaders
                                  .map((header) => Container(
                                        alignment: FractionalOffset.center,
                                        width: 120.0,
                                        margin: const EdgeInsets.all(0.0),
                                        padding: const EdgeInsets.only(
                                            top: 5.0,
                                            bottom: 5.0,
                                            right: 3.0,
                                            left: 3.0),
                                        child: Text(
                                          header,
                                          style: TextStyle(
                                              color: Colors.grey[800]),
                                          textAlign: TextAlign.center,
                                        ),
                                      ))
                                  .toList()
                            ]),
                          ),
                        ],
                      ),
                    ),
                    ...createRows(),
                    ButtonWidget(
                      onTap: () => _submit(),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ], //Create Rows
                ),
              ));
            })));
  }

  List<Widget> createRows() {
    List<Widget> allRows = []; //For Saving all Created Rows

    for (int i = 0; i < rowHeaders.length; i++) {
      List<Widget> singleRow = []; //For creating a single row
      for (int j = 0; j < columnHeaders.length; j++) {
        singleRow.add(Container(
            alignment: FractionalOffset.center,
            width: 120.0,
            padding: const EdgeInsets.only(
                top: 6.0, bottom: 6.0, right: 3.0, left: 3.0),
            child: Radio(
              value: j, //Index of created Radio Button
              groupValue: selected[rowHeaders[i]] ?? "",
              onChanged: (value) {
                setState(() {
                  selected[rowHeaders[i]] =
                      value; //Adding selected rowName with its Index in a Map tagged "selected"
                  //print("${rowHeaders[i]} ==> $value");
                });
              },
            )));
      }
      //Adding single Row to allRows widget
      allRows.add(Row(
        children: [
          Container(
            alignment: FractionalOffset.centerLeft,
            width: 140.0,
            padding: const EdgeInsets.only(
                top: 6.0, bottom: 6.0, right: 3.0, left: 10.0),
            child:
                Text(rowHeaders[i], style: TextStyle(color: Colors.grey[800])),
          ),
          ...singleRow
        ], //Add single row here
      ));
    }
    return allRows; //Return all single rows
  }
}
