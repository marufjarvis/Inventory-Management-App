// import 'package:get/get.dart';

// final kPadding = 8.0; // up to you
 
// class Snack {
//   /// show the snack bar
//   /// [content] is responsible for the text of the snack bar
//   static show({
//     required String content,
//     SnackType snackType = SnackType.info,
//     SnackBarBehavior behavior = SnackBarBehavior.fixed,
//   }) {
//     ScaffoldMessenger.of(Get.context!).showSnackBar(
//       SnackBar(
//         content: Text(
//           content,
//           style: Get.textTheme.headline5
//               ?.copyWith(color: _getSnackbarTextColor(snackType)),
//         ),
//         behavior: behavior,
//         backgroundColor: _getSnackbarColor(snackType),
//         padding: const EdgeInsets.symmetric(
//           horizontal: kPadding * 3,
//           vertical: kPadding * 2,
//         ),
//       ),
//     );
//   }

//   static Color _getSnackbarColor(SnackType type) {
//     if (type == SnackType.error) return const Color(0xffFF7A7A);
//     if (type == SnackType.warning) return Colors.amber;
//     if (type == SnackType.info) return Colors.blue;
//     return Colors.white;
//   }