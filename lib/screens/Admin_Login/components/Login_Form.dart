import 'package:attendance/helper/httpexception.dart';
// ignore: unused_import
import 'package:attendance/managers/App_State_manager.dart';
import 'package:attendance/managers/Auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Login_Form extends StatefulWidget {
  const Login_Form({Key? key}) : super(key: key);

  @override
  _Login_FormState createState() => _Login_FormState();
}

class _Login_FormState extends State<Login_Form> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late FocusNode myFocusNode;

  var _isLoading = false;

  bool _rememberme = false;
  Map<String, String> _authData = {
    'Email': '',
    'Password': '',
  };

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth_manager>(context, listen: false).login(
          _authData['Email'].toString(), _authData['Password'].toString());
      if (_rememberme)
        await Provider.of<Auth_manager>(context, listen: false).rememberMe();
    } on HttpException catch (error) {
      var errorMessage = 'These credentials do not match our records';
      if (error.toString().contains('credentials do not match'))
        _showErrorDialog('البيانات غير صحيحه');
    } catch (error) {
      const errorMessage = 'حاول مره اخري';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'حدث خطا',
          style: TextStyle(fontFamily: 'GE-Bold'),
        ),
        content: Text(
          message,
          style: TextStyle(fontFamily: 'GE-medium'),
        ),
        actions: <Widget>[
          Center(
            child: FlatButton(
              color: kbackgroundColor1,
              child: Text(
                'حسنا',
                style: TextStyle(fontFamily: 'GE-medium'),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: kTextColor1,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              onEditingComplete: () => myFocusNode.requestFocus(),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please type your Email *';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email address *';
                }
                return null;
              },
              onSaved: (value) {
                _authData['Email'] = value!;
              },
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              decoration: InputDecoration(
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                errorStyle: TextStyle(
                  textBaseline: TextBaseline.ideographic,
                  decoration: TextDecoration.none,
                  fontSize: 12,
                ),
                hintText: "Email",
                hintStyle:
                    TextStyle(color: kTextColor2.withOpacity(1), fontSize: 15),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr,
              focusNode: myFocusNode,
              onSaved: (value) {
                _authData['password'] = value!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please type your password *';
                }

                return null;
              },
              obscureText: true,
              keyboardType: TextInputType.text,
              scrollPadding: const EdgeInsets.only(bottom: 32.0),
              onChanged: (value) {
                _authData['Password'] = value;
              },
              decoration: InputDecoration(
                focusedErrorBorder: InputBorder.none,

                errorStyle: TextStyle(
                  textBaseline: TextBaseline.ideographic,
                  decoration: TextDecoration.none,
                  fontSize: 12,
                ),
                errorBorder: InputBorder.none,
                hintText: "Password",
                hintStyle:
                    TextStyle(color: kTextColor2.withOpacity(1), fontSize: 15),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
              ),
            ),
          ),
          if (!_isLoading)
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .1),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: CheckboxListTile(
                    title: Text('? Remember Me'),
                    value: _rememberme,
                    onChanged: (newval) {
                      setState(() {
                        _rememberme = newval!;
                      });
                    },
                    // selected: _rememberme,
                  ),
                ),
              ),
            ),
          if (_isLoading)
            Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: CircularProgressIndicator())
          else
            TextButton(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: kTextColor1,
                  backgroundColor: kbuttonColor1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                onPressed: () => _submit())
        ],
      ),
    );
  }
}
