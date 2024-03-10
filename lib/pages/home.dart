import 'dart:convert';

import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  static String quoteURL = 'https://api.quotable.io/random';
  static String quote = "Generating Quote...";
  static String author = "Anonymous";

  static Future<void> getQuote() async {
    try {
      final response = await http.get(
        Uri.parse(quoteURL),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
          quote = data['content'];
          author = data['author'];
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf43543),
      body: Center(
        child: Stack(children: [
          Center(
            child: Container(
              alignment: Alignment.centerRight,
              height: 400,
              width: 270,
              // padding: const EdgeInsets.all(40),
              color: Colors.white,
            ),
          ),
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                alignment: Alignment.center,
                // height: 350,
                width: 320,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Color(0xFFf43543),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(87, 11, 16, 0.4),
                      blurRadius: 25,
                      // offset: Offset.zero,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,


                  children: [
                    Text(
                      Home.quote,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: Color(0xFFfdd8d8),
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      Home.author.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Home.getQuote();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Get Quote',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFf43543),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ]),
      ),
      floatingActionButton: ElevatedButton.icon(
        icon: Icon(
          Icons.share_outlined,
          color: Color(0xFFf43543),
          size: 35,
        ),
        onPressed: () {
          Share.share("Quote: \"${Home.quote}\"\nAuthor: \"${Home.author}\"",subject: "Quote by ${Home.author}");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
          shape: CircleBorder(),
        ), label: Text(""),
      ),
    );
  }
}
