// import 'dart:async';
// import 'dart:io';

// import 'package:connectivity/connectivity.dart';

// class MyConnectivity {
//   MyConnectivity._();

//   static final _instance = MyConnectivity._();
//   static MyConnectivity get instance => _instance;
//   final _connectivity = Connectivity();
//   final _controller = StreamController.broadcast();
//   Stream get myStream => _controller.stream;

//   void initialise() async {
//     ConnectivityResult result = await _connectivity.checkConnectivity();
//     checkStatus(result);
//     _connectivity.onConnectivityChanged.listen((result) {
//       checkStatus(result);
//     });
//   }

//   static Future<bool> checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if( result.isNotEmpty && result[0].rawAddress.isNotEmpty){
//       isOnline=true;
//     } 
//     }on SocketException catch (_) {
//       isOnline = false;
//     }
//     //  _controller.sink.add({result: isOnline});
//     return isOnline;
//   }

//   void disposeStream() => _controller.close();

// //   Future<bool> hasNetwork() async {
// //   try {
// //     final result = await InternetAddress.lookup('example.com');
// //     return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
// //   } on SocketException catch (_) {
// //     return false;
// //   }
// // }
// //bool isOnline = await hasNetwork();
// }
