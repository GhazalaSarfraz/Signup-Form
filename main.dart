import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Signup Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const form(),
    );
  }
}

class form extends StatefulWidget {
  const form({super.key});

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  int _val = 1; //for Radio Button
  String? selectval; //for list box
  List<String> dropdownItem = ['BS IT', 'BS CS', 'BS SE'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter  an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? _validatePhoneNo(value) {
    if (value!.isEmpty) {
      return "Please enter a phone number";
    }
    if (value.length != 11) {
      return "Please enter a 11-digit phone number";
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value!.isEmpty) {
      return "Please enter a password";
    }
    if (value.length != 6) {
      return "Please enter a 6-alphanumeric password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Signup Form',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon:
                                Icon(Icons.drive_file_rename_outline_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a username";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: _validateEmail),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: _validatePassword),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Phone No',
                            prefixIcon: Icon(Icons.phone_android),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: _validatePhoneNo),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Shift',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('   Morning'),
                        Radio(
                            value: 1,
                            activeColor: Colors.blue,
                            groupValue: _val,
                            onChanged: (newval) {
                              setState(() {
                                _val = newval!;
                              });
                            }),
                        Text('  Evening'),
                        Radio(
                            value: 2,
                            activeColor: Colors.blue,
                            groupValue: _val,
                            onChanged: (newval) {
                              setState(() {
                                _val = newval!;
                              });
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: 'Degree',
                          prefixIcon: Icon(Icons.school_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      hint: Text('Degree'),
                      value: selectval,
                      onChanged: (String? newVal) {
                        setState(() {
                          selectval = newVal;
                        });
                      },
                      items: dropdownItem
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _usernameController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                            _phoneController.clear();
                            selectval = null;
                            _val = 1;
                          });
                          ScaffoldMessenger.of(_formKey.currentContext!)
                              .showSnackBar(
                            const SnackBar(
                                content: Text('Form Submitted Successfully')),
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Colors.teal,
                      height: 40,
                      minWidth: 150,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                )),
          ),
        ));
  }
}

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Material(
        color: Colors.teal,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/me.jpg',
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Ghazala Sarfraz',
                    style: TextStyle(fontSize: 28, color: Colors.white)),
                Text('ghazalawattoo123@gmail.com',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      );
}
