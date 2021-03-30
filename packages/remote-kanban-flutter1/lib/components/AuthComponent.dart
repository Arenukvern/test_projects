import 'package:flutter/material.dart';
import 'package:test_fl_kanban/entities/CommonError.dart';
import 'package:test_fl_kanban/entities/User.dart';
import 'package:test_fl_kanban/localizations/MainLocalizations.dart';
import 'package:test_fl_kanban/services/AuthService.dart';

class AuthComponent extends StatefulWidget {
  @override
  _AuthComponentState createState() => _AuthComponentState();
}

class _AuthComponentState extends State<AuthComponent> {
  User _user = User();

  final double _borderRadius = 40.0;
  final _formKey = GlobalKey<FormState>();

  UserError _userErrors = UserError(commonError: CommonError());
  final _authService = AuthService();
  _field(
      {@required String labelText,
      @required Function validator,
      @required Function onChanged,
      bool obscureText}) {
    return Container(
        width: double.infinity,
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_borderRadius)),
            hintText: labelText,
          ),
          onChanged: onChanged,
          textAlign: TextAlign.center,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText ?? false,
        ));
  }

  _submitButton() {
    _submitData() async {
      if (_formKey.currentState.validate()) {
        _userErrors = UserError(commonError: CommonError());
        try {
          var _userErrorsAuth = await _authService.login(_user);

          if (_userErrorsAuth != null) {
            setState(() {
              _userErrors = _userErrorsAuth;
            });
          } else {
            Navigator.of(context).pushNamed('/tasks');
          }
        } catch (e) {
          print(e);
        }
      }
    }

    return Container(
      width: double.infinity,
      height: 50.0,
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
            side: BorderSide(color: Theme.of(context).accentColor)),
        onPressed: _submitData,
        hoverColor: Theme.of(context).accentColor.withGreen(220),
        child: Text(
          MainLocalizations.of(context).login,
          style: TextStyle(color: Theme.of(context).backgroundColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: _userErrors.commonError.isMessageEmpty &&
                    _userErrors.nonFieldErrors.isEmpty
                ? 0.0
                : 1.0,
            child: Center(
                child: Text(
              _userErrors.nonFieldErrors.isNotEmpty
                  ? _userErrors.nonFieldErrors
                  : _userErrors?.commonError?.message ?? '',
              style: TextStyle(color: Colors.red),
            )),
          ),
          SizedBox(
            height: 20.0,
          ),
          _field(
              labelText: MainLocalizations.of(context).enterYourUsername,
              onChanged: (newValue) => _user.username = newValue,
              validator: (value) {
                if (_userErrors.user.username != null &&
                    _userErrors.user.username[0].isNotEmpty) {
                  return _userErrors.user.username[0];
                }
                return value.length < 4
                    ? MainLocalizations.of(context).usernameValidationMessage
                    : null;
              }),
          SizedBox(
            height: 20.0,
          ),
          _field(
              labelText: MainLocalizations.of(context).enterYourPassword,
              onChanged: (newValue) => _user.password = newValue,
              validator: (value) {
                if (_userErrors.user.password != null &&
                    _userErrors.user.password[0].isNotEmpty) {
                  return _userErrors.user.password[0];
                }
                return value.length < 8
                    ? MainLocalizations.of(context).passwordValidationMessage
                    : null;
              },
              obscureText: true),
          SizedBox(
            height: 40.0,
          ),
          _submitButton()
        ],
      ),
    );
  }
}
