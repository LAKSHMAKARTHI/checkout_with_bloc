import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:checkout/modules/splash/splash.dart';
import 'package:checkout/modules/home/home.dart';
import 'package:checkout/modules/details/details.dart';

void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Check Out",
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider<SplashBloc>(
          create: (context) => SplashBloc()..add(SplashTriggerEvent()),
          child: SplashScreen(),
        ),
        '/home': (context) => BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(HomeTriggerEvent()),
          child: HomeScreen(),
        ),
        '/details': (context) => BlocProvider<DetailsBloc>(
          create: (context) => DetailsBloc(),
          child: DetailsScreen(),
        )
      },
    );
  }
}