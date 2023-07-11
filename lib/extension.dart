// import 'dart:html';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// extension ContextExtension on BuildContext {

//   showSnackBar(String message) {

//     ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));

//   }




//   Future showDialog(String title, String message) {

//     if (Platform.isIOS) {

//       return showCupertinoDialog(

//         context: this,

//         builder: (context) => CupertinoAlertDialog(

//           title: title.toText(),

//           content: message.toText(),

//           actions: [

//             CupertinoDialogAction(

//               onPressed: () => Navigator.of(context).pop(),

//               child: 'OK'.toText(

//                 style: context.labelSmall!.copyWith(

//                   color: AppColors.cgsPrimaryButton,

//                 ),

//               ),

//             ),

//           ],

//         ),

//       );

//     } else {

//       return showGeneralDialog(

//         context: this,

//         barrierDismissible: true,

//         barrierLabel: 'Dialog',

//         transitionDuration: const Duration(milliseconds: 200),

//         pageBuilder: (context, animation1, animation2) {

//           return AlertDialog(

//             title: title.toText(

//                 style: context.labelLarge!.copyWith(

//               color: darkTheme.value ? Colors.white : Colors.black,

//             )),

//             content: message.toText(style: context.labelSmall),

//             actions: [

//               TextButton(

//                 onPressed: () => Navigator.of(context).pop(),

//                 child: 'OK'.toText(

//                   style: context.labelSmall!.copyWith(

//                     color: AppColors.cgsPrimaryButton,

//                   ),

//                 ),

//               ),

//             ],

//           );

//         },

//       );

//     }

//   }

// }