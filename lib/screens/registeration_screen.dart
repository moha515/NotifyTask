import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notifytask/screens/Task_screen.dart';
import 'package:notifytask/screens/cubits/login_cubit/registeration_cubit.dart';
import 'package:notifytask/widgets/login_button.dart';
import 'package:notifytask/widgets/text_fields.dart';
import 'package:notifytask/helper/show_snack_bar.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registrationScreen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email, password, confirmPassword;
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterationCubit, RegisterationState>(
      listener: (context, state) {
        if (state is RegistrationLoading) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }

        if (state is RegistrationFailure) {
          showSnackBar(context, state.errorMssg);
        } else if (state is RegistrationSuccess) {
          context.go('/tasks');
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Color(0xFF303841),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        ClipOval(
                          child: Image.asset(
                            'lib/assets/taskly.png',
                            height: 300,
                            width: 400,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomFormTextField(
                          onChanged: (data) {
                            email = data;
                          },
                          hintText: 'Email',
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomFormTextField(
                          obscureText: !isPasswordVisible,
                          onChanged: (data) {
                            password = data;
                          },
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomFormTextField(
                          obscureText: !isConfirmPasswordVisible,
                          onChanged: (data) {
                            confirmPassword = data;
                          },
                          hintText: 'Re-enter Password',
                          suffixIcon: IconButton(
                            icon: Icon(isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomButon(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              if (password == confirmPassword) {
                                BlocProvider.of<RegisterationCubit>(context)
                                    .registerUser(
                                        email: email!, password: password!);
                              } else {
                                showSnackBar(context, 'Passwords do not match');
                              }
                            }
                          },
                          text: 'REGISTER',
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/');
                          },
                          child: Text(
                            'Already have an account? Login here',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
