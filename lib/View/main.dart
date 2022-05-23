import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicall/Providers/edit_hospital_provider.dart';
import 'package:medicall/Providers/nearest_location_provider.dart';
import 'package:medicall/Providers/hospital_login_provider.dart';
import 'package:medicall/Providers/hospital_register_provider.dart';
import 'package:medicall/Providers/paramedic_login_provider.dart';
import 'package:medicall/Providers/patient_form_provider.dart';
import '../Providers/patient_list_provider.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NearestLocationProvider()),
        ChangeNotifierProvider(create: (_) => HospitalRegisterProvider()),
        ChangeNotifierProvider(create: (_) => PatientFormProvider()),
        ChangeNotifierProvider(create: (_) => HospitalLoginProvider()),
        ChangeNotifierProvider(create: (_) => EditHospitalProvider()),
        ChangeNotifierProvider(create: (_) => PatientListProvider()),
        ChangeNotifierProvider(create: (_) => ParamedicLoginProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff353559),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    initAnimation();
    //check_if_already_login();
  }

  late bool newUser;
  bool isPlaying = true;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 1.0).animate(_controller);

  void initAnimation() async {
    Future.delayed(const Duration(seconds: 2), () {
      _controller.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  startTimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(30.0),
            decoration: const BoxDecoration(
              color: Color(0xFFF7E9EB),
              shape: BoxShape.circle,
            ),
            child: const Image(
              image: AssetImage('Assets/Medicall (8).png'),
            ),
          ),
        ),
      ),
    );
  }
}
