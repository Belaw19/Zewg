// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import 'package:z/core/constants/route_paths.dart';
// import 'package:z/features/auth/presentation/widgets/admin_login_form.dart';

// class AdminLoginPage extends StatelessWidget {
//   const AdminLoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9FB),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Zewg',
//                   style: TextStyle(
//                     fontSize: 48,
//                     fontWeight: FontWeight.w900,
//                     color: Color(0xFF004D61),
//                   ),
//                 ),
//                 const SizedBox(height: 60),
//                 AdminLoginForm(
//                   onSignedIn: () => context.go(RoutePaths.adminDashboard),
//                 ),
//                 const SizedBox(height: 100),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
