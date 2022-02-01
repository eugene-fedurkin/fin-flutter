import 'dart:async';

import 'package:flutter/material.dart';
import 'package:organizer/providers/shared_state.dart';
import 'package:organizer/screens/categories_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SharedState>.value(value: SharedState())
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const CategoriesScreen()
        },
      ),
    );
    
    // return MaterialApp(
    //     home: CategoriesScreen()
    // );
  }
}

// class _FirstAppState extends State<MyFirstApp> {
//   bool _loading = false;
//   double _progressValue = 0;

//   @override
//   void initState() {
//     _loading = false;
//     _progressValue = 0;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.indigo,
//         appBar: AppBar(
//           title: Text('My First App'),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Container(
//             padding: EdgeInsets.all(16),
//             child: _loading
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       LinearProgressIndicator(value: _progressValue),
//                       Text(
//                         '${(_progressValue * 100).round()}',
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     ],
//                   )
//                 : Text(
//                     'Press button',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _loading = !_loading;
//               _updateProgress();
//             });
//           },
//           child: Icon(Icons.cloud_download),
//         ),
//       ),
//     );
//   }

//   void _updateProgress() {
//     const onSec = const Duration(seconds: 1);
//     Timer.periodic(onSec, (Timer t) {
//       setState(() {
//         _progressValue += 0.2;
//         if (_progressValue.toStringAsFixed(1) == '1.0') {
//           _loading = false;
//           t.cancel();
//           _progressValue = 0.0;
//           return;
//         }
//       });
//     });
//   }
// }

// class MyFirstApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.indigo,
//         appBar: AppBar(
//           title: Text('My First App'),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Container(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 LinearProgressIndicator(value: 23),
//                 Text(
//                   '23 %',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 Text(
//                   'Press button',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 )
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: null,
//           child: Icon(Icons.cloud_download),
//         ),
//       ),
//     );
//   }
// }
