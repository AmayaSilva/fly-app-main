import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fly_app/models/user_data.dart';
import 'package:fly_app/screens/question_set2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/button_widget.dart';

class TableViewOne extends StatefulWidget {
  static const routeName = '/questionnaire1';

  const TableViewOne({Key? key}) : super(key: key);

  @override
  //_TableViewOneState createState() => _TableViewOneState();
  State<StatefulWidget> createState() {
    return _TableViewOneState();
  }
}

class _TableViewOneState extends State<TableViewOne> {
  List rowHeaders = [];
  List columnHeaders = [];
  Map selected = {};
  late int sc;

  //final answerController = TextEditingController();
  @override
  void initState() {
    super.initState();
    saveHeaders(); //Iterate and store all Row and column Headers
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  // void inputData() {
  //   final User? user = auth.currentUser;
  //   final uid = user?.uid;
  //   // here you write the codes to input the data into firestore
  // }

  void _submit() {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    print(uid);
    //sumSelected();
    addScoreDetails(uid, sumSelected());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TableView()));
  }

  num sumSelected() {
    num sum = 0;
    for (int i = 0; i < selected.length; i++) {
      sum += selected[rowHeaders[i]];
    }
    return sum;
  }

  // addScoreDetails() {
  //   UserData.atcid;
  //   sumSelected();
  // }

  Future addScoreDetails(uid, num sum) async {
    //final prefs = await SharedPreferences.getInstance();
    //final String? uid = prefs.getString('uid');
    await FirebaseFirestore.instance
        .collection('results')
        //.add({'atco_email': email, 'atco_password': password});
        .doc(uid)
        .set({
      // "atco_id": _user?.atcid,
      // "atco_email": _user?.email,
      //"atco_id": UserData.atcid,
      "uid": uid,
      "que_one_score": sum,
    }, SetOptions(merge: true));
  }

  saveHeaders() {
    //Saving All Headers
    columnHeaders.addAll(["1", "2", "3", "4", "5", "6", "7"]);
    rowHeaders.addAll([
      "My motivation is lower when I do long shifts",
      "Exercise reduces my mood",
      "I am easily exhausted",
      "Workload interferes with my physical functioning",
      "I get frequent exhaustion",
      "I find difficult to sustain my physical functions due to my hectic workload and rosters",
      "My duties and responsibilities are depreciated due to due to stress & physical tiredness",
      "Fatigue is among my three most disabling symptoms",
      "Fatigue interferes work, family and social life"
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              //title: const Text("Answer all the questions"),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Step 01",
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
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                    ...createRows(),
                    ButtonWidget(
                      onTap: () => _submit(),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //  // ElevatedButton(onPressed: Navigator.push(context, MaterialPageRoute(builder: (context)) => const TableView()), child: null,;), child: const Text(
                    //       'Next',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         color: Colors.white,
                    //       ))
                  ], //Create Rows
                ),
              ));
            })));
  }

  List<Widget> createRows() {
    List<Widget> allRows = []; //For Saving all Created Rows

    for (int i = 0; i < rowHeaders.length; i++) {
      List<Widget> singleRow = []; //For creating a single row
      for (int j = 1; j <= columnHeaders.length; j++) {
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
