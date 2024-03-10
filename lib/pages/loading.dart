import 'package:connectivity/connectivity.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:quotes_app/pages/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void setupWorldTime() async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "An error occurred during data retrieval!",
        onConfirmBtnTap: (){
          setupWorldTime();
        },
      );
    } else {
      await Home.getQuote();
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacementNamed(context,'/home');
    }
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf43543),
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 100.0,
        ),
      )
    );
  }
}
