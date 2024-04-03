import 'package:fire_auth_crud/ui/auth/sign_up_screen.dart';
import 'package:fire_auth_crud/ui/home_screen.dart';
import 'package:fire_auth_crud/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignIn Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          children: [
            FormWidget(
                formKey: _formKey,
                emailTEController: _emailTEController,
                passwordTEController: _passwordTEController),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text("Sign Up")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTEController,
    required TextEditingController passwordTEController,
  })  : _formKey = formKey,
        _emailTEController = emailTEController,
        _passwordTEController = passwordTEController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTEController;
  final TextEditingController _passwordTEController;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isProgress = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget._emailTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              labelText: "E-mail",
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your E-mail";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: widget._passwordTEController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              labelText: "Password",
              prefixIcon: const Icon(Icons.lock_outlined),
            ),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter your Password";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (widget._formKey.currentState!.validate()) {
                  _isProgress = true;
                  setState(() {});
                  _auth
                      .signInWithEmailAndPassword(
                          email: widget._emailTEController.text
                              .trim()
                              .toString(),
                          password:
                              widget._passwordTEController.text.toString())
                      .then((value) {
                    _isProgress = false;
                    setState(() {});
                    widget._emailTEController.clear();
                    widget._passwordTEController.clear();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ), (route) => false);
                  }).onError((error, stackTrace) {
                    setState(() {});
                    _isProgress = false;
                    Utils.toastMessage(error.toString());
                  });
                }
              },
              child: Visibility(
                visible: _isProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2,color: Colors.white,),
                ),
                  child: const Text("Login"),),
            ),
          ),
        ],
      ),
    );
  }
}
