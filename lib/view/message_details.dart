// import 'package:flutter/material.dart';

// import '../models/birthday_message.dart';

// class MessageDetailPage extends StatelessWidget {
//   final BirthdayMessage message;

//   const MessageDetailPage({super.key, required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           Hero(
//             tag: message.name,
//             child: Image.asset(message.image, fit: BoxFit.cover),
//           ),

//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black]),
//             ),
//           ),

//           SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                   ),

//                   const SizedBox(height: 250),

//                   Text(
//                     message.name,
//                     style: const TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),
//                   ),

//                   // const SizedBox(height: 10),

//                   // Text(message.relation, style: const TextStyle(color: Colors.white70, fontSize: 18)),
//                   const SizedBox(height: 24),

//                   Text(message.message, style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.8)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
