import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:http/http.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandomJokes(),

    );
  }
}

class RandomJokes extends StatefulWidget {
  const RandomJokes({super.key});

  @override
  State<RandomJokes> createState() => _RandomJokesState();
}

class _RandomJokesState extends State<RandomJokes> {

  final random = Random();
  int randomNumber =0 ;
  String l1 = '';
  String l2 = '';
  String l3 = '';

  @override
  void initState() {
    super.initState();

  }

  Future<void> getJokes() async {
   Response response = await get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));
   print(response.statusCode);
   print(response.body);
   final Map<String,dynamic> decodedResponse = jsonDecode(response.body);
    l1 = decodedResponse['type'];
    l2 = decodedResponse['setup'];
    l3 = decodedResponse['punchline'];

  }

  void number(){
    setState(() {
      randomNumber = random.nextInt(15)+1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade200,
        title: const Text('Random Jokes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Colors.red.shade200,
                      width: 1.5
                  )
              ),
              child:  Center(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l1 ?? '' ,style: TextStyle(color: Colors.black),),
                    Text(l2 ?? '' ),
                    Text(l3 ?? '' ),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.red.shade200,
                        width: 1.5
                    )
                ),
                child: Image.asset('images/OIP$randomNumber.jpeg'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                number();
                getJokes();
              },
                  style:ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    onPrimary: Colors.white,
                    primary: Colors.red.shade300,
                    elevation: 5,
                  ),
                  child: const Text('One More')
              ),
            ),
          )
        ],
      ),
    );
  }
}

