import 'package:flutter/material.dart';
import 'login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Container(
            // ignore: prefer_const_constructors
            padding:
                EdgeInsets.only(top: 100.0, left: 0.0, bottom: 0.0, right: 0.0),
            child: const Text('Detailing Their',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Inter-Black',
                    fontSize: 26.0,
                    letterSpacing: -1.0,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 00.0, left: 0.0, bottom: 0.0, right: 0.0),
            child: const Text('Progress Anywhere.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Inter-Black',
                    fontSize: 26.0,
                    letterSpacing: -1.0,
                    fontWeight: FontWeight.bold)),
          ),
          Center(
            child: Image.asset(
              "assets/images/manager-landing-page.png",
              width: 300,
              height: 300,
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(
          //         builder: (context) => const LoginScreen()));
          //   },
          //   child: const Text(
          //     "Get Started",
          //   ),
          //   style: TextButton.styleFrom(
          //     backgroundColor: Color.fromARGB(255, 255, 126, 45),
          //     // ignore: deprecated_member_use
          //     primary: Colors.white,
          //     minimumSize: const Size(200.0, 40.0),
          //     //textStyle: GoogleFonts.montserrat(),
          //     shape: const StadiumBorder(),
          //   ),
          // ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },

            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                backgroundColor: const Color.fromARGB(255, 255, 126, 45),
                elevation: 12.0,
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter-Bold',
                    fontSize: 18)),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
