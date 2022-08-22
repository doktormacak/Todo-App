// import 'package:flutter/material.dart';
// import 'package:todo_game/widgets/button.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//   static Page<void> page() => const MaterialPage<void>(child: LoginPage());
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool isButtonPressed = false;
//   void buttonPressed() {
//     setState(() {
//       if (isButtonPressed == false) {
//         isButtonPressed = true;
//       } else if (isButtonPressed == true) {
//         isButtonPressed = false;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF661f4f),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 100,
//             width: 100,
//           ),
//           const SizedBox(
//             child: Icon(Icons.rocket_launch, color: Colors.white, size: 60.0),
//           ),
//           const SizedBox(height: 10.0),
//           Container(
//             alignment: Alignment.center,
//             child: const Text(
//               'TodoNFT',
//               style: TextStyle(
//                 fontSize: 36.0,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 100,
//             width: 100,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color.fromARGB(255, 0, 0, 0),
//                     offset: Offset(6, 12),
//                     blurRadius: 20,
//                     spreadRadius: 1,
//                   ),
//                   BoxShadow(
//                     color: Color.fromARGB(255, 215, 68, 166),
//                     // color: Color(0xFF83B692),
//                     offset: Offset(-8, -6),
//                     blurRadius: 20,
//                     spreadRadius: 1,
//                   ),
//                 ],
//                 color: const Color(0xFF661f4f),
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.only(left: 20.0),
//                 child: TextField(
//                   cursorColor: Colors.white,
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.only(left: 10.0, right: 31.0),
//                     border: InputBorder.none,
//                     hintText: 'Email',
//                     hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
//                     suffix: Icon(Icons.mail_outline,
//                         color: Colors.white, size: 20.0),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 65.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color.fromARGB(255, 0, 0, 0),
//                     offset: Offset(6, 12),
//                     blurRadius: 20,
//                     spreadRadius: 1,
//                   ),
//                   BoxShadow(
//                     color: Color.fromARGB(255, 215, 68, 166),
//                     // color: Color(0xFF83B692),
//                     offset: Offset(-8, -6),
//                     blurRadius: 20,
//                     spreadRadius: 1,
//                   ),
//                 ],
//                 color: const Color(0xFF661f4f),
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.only(left: 20.0),
//                 child: TextField(
//                   cursorColor: Colors.white,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.only(left: 10.0, right: 31.0),
//                     border: InputBorder.none,
//                     hintText: 'Password',
//                     hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
//                     suffix: Icon(Icons.lock_outline,
//                         color: Colors.white, size: 20.0),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 65.0,
//           ),
//           CoolButton(isButtonPressed: isButtonPressed, onTap: buttonPressed),
//           const SizedBox(
//             height: 30.0,
//           ),
//           const Text('Forgot your password?',
//               style: TextStyle(fontSize: 15.0, color: Colors.white)),
//           const SizedBox(
//             height: 65.0,
//           ),
//           GestureDetector(
//               onTap: () {},
//               child: Container(
//                 height: 60,
//                 width: MediaQuery.of(context).size.width * 0.65,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.white, width: 3)),
//                 child: const Center(
//                   child: Text('Register',
//                       style: TextStyle(fontSize: 24, color: Colors.white)),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_game/auth_repository.dart';
import 'package:todo_game/pages/cubit/login_cubit.dart';
import 'package:todo_game/pages/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child:  LoginForm(),
        ),
      ),
    );
  }
}
