import 'package:flutter/material.dart';
import 'package:flutter_chatbot/app/services/firebase_auth_service.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/entry_field.dart';
import 'package:flutter_chatbot/ui/widgets/auth/forms/form_submit.dart';
import 'package:provider/provider.dart';

// Need error handling design
class CreateAccountForm extends StatefulWidget {
  @override
  _CreateAccountFormState createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();

  String email, password, confirmPassword;

  String errorMessage = "";

  final List<String> errorCodes = ["invalid-email", "email-already-in-use"];

  final List<String> errorMessages = [
    "Invalid email.",
    "Email already in use.",
    "Password must have at least 8 characters.",
    "Passwords do not match.",
    "Some error occured. Please try again."
  ];

  void saveEmail(String newValue) => email = newValue;
  void savePassword(String newValue) => password = newValue;
  void saveConfirmPassword(String newValue) => confirmPassword = newValue;

  void onSubmit() {
    setState(() {
      errorMessage = "";
    });
    _formKey.currentState.save();
    if (password.length < 8) {
      setState(() {
        errorMessage = errorMessages[2];
      });
    } else if (password != confirmPassword) {
      setState(() {
        errorMessage = errorMessages[3];
      });
    } else {
      Provider.of<AuthService>(context, listen: false)
          .createRegularAccount(email, password)
          .then((res) {
        if (res != "Success.") {
          switch (errorCodes.indexOf(res)) {
            case 0:
              {
                setState(() {
                  errorMessage = errorMessages[0];
                });
              }
              break;
            case 1:
              {
                setState(() {
                  errorMessage = errorMessages[1];
                });
              }
              break;
            case -1:
              {
                setState(() {
                  errorMessage = errorMessages[4];
                });
              }
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Text(
            errorMessage,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 12, color: Color(0xFFEB5757)),
          ),
          // Make entry type email
          EntryField(
              hintText: "Email",
              topMargin: 10,
              obscureText: false,
              saveValue: saveEmail),
          EntryField(
              hintText: "Password",
              topMargin: 20,
              obscureText: true,
              saveValue: savePassword),
          EntryField(
              hintText: "Confirm Password",
              topMargin: 20,
              obscureText: true,
              saveValue: saveConfirmPassword),
          FormSubmit(
            topMargin: 50,
            text: "Create Account",
            onSubmit: onSubmit,
          )
        ]));
  }
}
