import 'package:fire_auth_crud/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: FormWidget(
          formKey: _formKey,
          emailTEController: _emailTEController,
          passwordTEController: _passwordTEController,
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
                labelText: "E-mail"),
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
                labelText: "Password"),
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
                      .createUserWithEmailAndPassword(
                          email: widget._emailTEController.text.trim().toString(),
                          password: widget._passwordTEController.text.toString())
                      .then((value) {
                        _isProgress= false;
                        setState(() {

                        });
                        widget._emailTEController.clear();
                        widget._passwordTEController.clear();
                        Utils.toastMessage("Account Created");

                  })
                      .onError((error, stackTrace) {
                        _isProgress = false;
                        setState(() {

                        });

                    Utils.toastMessage(error.toString());
                  });
                }
              },
              child:  Visibility(
                  visible: _isProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(strokeWidth: 3,color: Colors.white,),
                  ),
                  child:const Text("SignUp"),),
            ),
          ),
        ],
      ),
    );
  }
}
