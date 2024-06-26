import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notifytask/screens/cubits/login_cubit/login_cubit.dart';
import 'package:notifytask/widgets/login_button.dart';
import 'package:notifytask/widgets/text_fields.dart';
import 'package:notifytask/helper/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;

  bool isLoading = false;
  bool isPasswordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }

        if (state is LoginFailure) {
          showSnackBar(context, state.errorMssg);
        } else if (state is LoginSuccess) {
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
                          'Login',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
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
                        CustomButon(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).loginUser(context: context,
                                  email: email!, password: password!);
                            } else {}
                          },
                          text: 'LOGIN',
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/register');
                          },
                          child: Text(
                            'Don\'t have an account? Register here',
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
