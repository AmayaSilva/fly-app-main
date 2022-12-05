// import 'package:flutter/material.dart';
// import 'package:fly_app/screens/auth.dart';
// import 'package:fly_app/widgets/button_widget.dart';

// class RecordsScreen extends StatefulWidget {
//   static const routeName = '/records';

//   const RecordsScreen({Key? key}) : super(key: key);

//   @override
//   State<RecordsScreen> createState() => _RecordsScreenState();
// }

// class _RecordsScreenState extends State<RecordsScreen> {
//   List<Map<String, dynamic>> records = [
//     {
//       "date": "2022-01-01",
//       "time": "08:00 AM",
//       "progress": 0.8,
//     },
//     {
//       "date": "2022-01-02",
//       "time": "09:00 AM",
//       "progress": 0.7,
//     },
//     {
//       "date": "2022-01-03",
//       "time": "10:00 AM",
//       "progress": 0.85,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           'Records',
//           style: TextStyle(
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: List.generate(
//                 records.length,
//                 (index) => Container(
//                   margin: const EdgeInsets.only(bottom: 10),
//                   color: Theme.of(context).colorScheme.secondary,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 15.0,
//                       horizontal: 10.0,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           records[index]["date"],
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           records[index]["time"],
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Container(
//                               height: 65,
//                               width: 65,
//                               padding: const EdgeInsets.all(10.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                               ),
//                               child: CircularProgressIndicator(
//                                 value: records[index]["progress"],
//                                 backgroundColor: Colors.grey.shade400,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Theme.of(context).colorScheme.secondary,
//                                 ),
//                                 strokeWidth: 7,
//                               ),
//                             ),
//                             Text(
//                               '${(records[index]["progress"] * 100).toStringAsFixed(0)}%',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Theme.of(context).colorScheme.secondary,
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ButtonWidget(
//                 child: const Text(
//                   'Exit',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.of(context).pushNamedAndRemoveUntil(
//                     AuthScreen.routeName,
//                     (route) => false,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
