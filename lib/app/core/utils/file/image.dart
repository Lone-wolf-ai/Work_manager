// import 'dart:io';

// import 'package:flutter/material.dart';

// class ShowImage extends StatelessWidget {
//   const ShowImage({
//     super.key,
//     required this.imagePath,
//   });

//   final String imagePath;

//   @override
//   Widget build(BuildContext context) {
//     final height=MediaQuery.of(context).size.height;
//     final width=MediaQuery.of(context).size.width;
//     return Center(
//       child: Container(
//         width: width*0.640,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.white, width: 0.5),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: SizedBox(
//             height: height*0.4,
//             child: Image.file(
//               File(imagePath),
//               filterQuality: FilterQuality.high,
//               fit: BoxFit.fill,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }