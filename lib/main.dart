import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuthorised = false;
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState() {
    super.initState();
    _isAuthorised = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isAuthorised ? Icons.check_circle_outlined : Icons.cancel,
              color: _isAuthorised
                  ? const Color.fromRGBO(78, 249, 4, 1)
                  : Colors.red,
              size: 250,
            ),
            Text(
              _isAuthorised ? 'Authorised' : 'Not Authorised',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    bool isAuth =
                        await auth.authenticate(localizedReason: 'Authorize');

                    setState(() {
                      _isAuthorised = isAuth;
                    });
                  } on Exception catch (e) {
                    debugPrint(e.toString());
                    setState(() {
                      _isAuthorised = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: const Text(
                  "Get Permission",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
