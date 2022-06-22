import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vivah/screens/core/constant.dart';
import 'package:vivah/screens/rating/rating_screen.dart';

ValueNotifier<bool> isCheckerNotifier = ValueNotifier(false);

class CustomerInfo extends StatefulWidget {
  static String id = 'customer_screen';
  const CustomerInfo({Key? key}) : super(key: key);

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  String name = "";
  String phone = '';
  String email = "";
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.amber;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  'assets/images/vivah.png',
                  fit: BoxFit.contain,
                ),
              ),

              // Name
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'What do people call you?',
                  labelText: 'Name *',
                ),
                onChanged: (val) => {
                  setState(
                    () => name = val,
                  )
                },
              ),
              kHeight10,

              // Email
              TextFormField(
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value!)) {
                    return 'Enter Valid Email';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter your email?',
                  labelText: 'Email *',
                ),
                onChanged: (val) => {
                  setState(
                    () => email = val,
                  )
                },
              ),
              kHeight10,

              // Mobile Number
              TextFormField(
                validator: (value) {
                  if (value!.length != 10 || value.isEmpty) {
                    return 'Mobile Number must be of 10 digit';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'Enter your mobile number',
                  labelText: 'Phone *',
                ),
                onChanged: (val) => {
                  setState(
                    () => phone = val,
                  )
                },
              ),
              kHeight10,

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    kWidtht10,
                    const Text('Are You Interested to get updates?'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> customerData = {
                    'name': name,
                    'email': email,
                    'phone': phone,
                    'createdAt': FieldValue.serverTimestamp()
                  };
                  print(customerData);
                  if (isChecked) {
                    FirebaseFirestore.instance
                        .collection('customerInfo')
                        .add(customerData);
                  }
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RatingScreen(
                            customerName: name,
                            customerEmail: email,
                            customerPhone: phone),
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(),
                child: const Text('NEXT'),
              ),
              kHeight10
            ],
          ),
        ),
      ),
    );
  }
}
