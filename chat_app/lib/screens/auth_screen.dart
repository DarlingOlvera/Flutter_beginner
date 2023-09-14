import 'dart:io';
import 'package:chat_app/widgets/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

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
  var _isAuthenticating = false;
  var _username = '';
  File? _image;

  void _onSubmit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || !_isLogin && _image == null) {
      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _email, password: _password);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');
        await storageRef.putFile(_image!);
        final imageUrl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _username,
          'email': _email,
          'image_url': imageUrl,
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
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
                            if (!_isLogin)
                              ImagePickerWidget(
                                onPickImage: (pickedImage) {
                                  _image = pickedImage;
                                },
                              ),
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
                            if (!_isLogin)
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 4) {
                                    return 'Please entera username with at least 4 characters';
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  _username = value!;
                                },
                              ),
                            if (!_isLogin)
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
                                if (!_isLogin) {
                                  if (value == null ||
                                      value.trim().length < 8) {
                                    return 'Password must be at least 8 characters long';
                                  }
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
                            if (_isAuthenticating)
                              CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            if (!_isAuthenticating)
                              ElevatedButton(
                                onPressed: _onSubmit,
                                child: Text(_isLogin ? 'Log in' : 'Sign up'),
                              ),
                            if (!_isAuthenticating)
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
                  padding: const EdgeInsets.only(top: 65),
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
