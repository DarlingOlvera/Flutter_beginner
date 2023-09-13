import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _email = '';
  var _password = '';

  void _onSubmit() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      print(_email);
      print(_password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 227),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.minPositive,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 65),
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  margin: const EdgeInsets.only(
                      top: 40, bottom: 20, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 60, bottom: 40, left: 20, right: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'The field email address is required';
                                }
                                final bool isEmail =
                                    EmailValidator.validate(value);
                                if (isEmail == false) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _email = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              obscureText: true, //esconde los caracteres
                              validator: (value) {
                                if (value == null || value.trim().length < 8) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              onPressed: _onSubmit,
                              child: Text(_isLogin ? 'Log in' : 'Sign up'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'I already have an account'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -100,
                left: 100,
                right: 100,
                child: Container(
                  padding: EdgeInsets.only(top: 65),
                  margin: const EdgeInsets.only(
                    top: 30,
                    left: 20,
                    right: 20,
                  ),
                  width: 200,
                  child: Image.asset('assets/images/chat.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
