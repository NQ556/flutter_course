import 'package:basic_dart/models/animal.dart';
import 'package:basic_dart/models/cat.dart';
import 'package:basic_dart/models/dog.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Animal> animals = [];
  String sound = "";

  void getAnimal() {
    setState(() {
      animals.add(Dog("Doggo"));
      animals.add(Cat("Kitty"));
    });
  }

  Future<void> fetchAnimals() async {
    await Future.delayed(const Duration(seconds: 2));
    getAnimal();
  }

  Stream<int> numberStream() async* {
    for (int i = 0; i <= 5; i++) {
      await Future.delayed(const Duration(seconds: 2));
      yield i;
    }
  }

  @override
  void initState() {
    fetchAnimals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: ListView.builder(
                itemCount: animals.length,
                itemBuilder: (context, index) {
                  final animal = animals[index];
                  return ListTile(
                    title: Text(
                      animal.name,
                    ),
                    subtitle: Text(animal is Dog ? "Dog" : "Cat"),
                    onTap: () {
                      animal.makeSound();
                    },
                  );
                }),
          ),

          //
          StreamBuilder(
              stream: numberStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Text("Current Number: ${snapshot.data}");
                } else {
                  return const Text("Complete");
                }
              }),
        ],
      ),
    );
  }
}
