import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'phonetest@gmail.com');
  final _passwordController = TextEditingController(text: '12345');

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1CB173),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset('assets/images/login_image.png'),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "Login To Your Account",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          key: const ValueKey('email address'),
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Emaill Address",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          key: const ValueKey('password'),
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: "Password",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // Row(
                        //   children: [
                        //     Switch(
                        //       value: isSwitched,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           isSwitched = value;
                        //         });
                        //       },
                        //       activeTrackColor: const Color(0xFFDCDBDB),
                        //       activeColor: const Color(0xFF108A00),
                        //     ),
                        //     Text(
                        //       isSwitched ? 'applicant' : 'Applicant',
                        //       style: const TextStyle(fontSize: 20),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await ref
                                    .read(authViewModelProvider.notifier)
                                    .loginApplicant(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                              }
                            },
                            child: const Text("Login"),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("or Login with"),
                            const SizedBox(
                              width: 21,
                            ),
                            SizedBox(
                              height: 24,
                              child: Image.asset("assets/icons/facebook.png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("Facebook"),
                            const SizedBox(
                              width: 21,
                            ),
                            SizedBox(
                              height: 24,
                              child: Image.asset("assets/icons/google.png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("Google"),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          thickness: 2,
                          color: Color(0xFFCCC7C7), // Color of the divider
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don’t Have An Account?"),
                            const SizedBox(
                              width: 3,
                            ),
                            GestureDetector(
                              onTap: () {
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .openRegisterView();
                              },
                              child: const Text(
                                "Register here",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
