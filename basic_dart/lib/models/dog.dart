import 'package:basic_dart/models/animal.dart';

class Dog extends Animal {
  Dog(super.name);

  @override
  void makeSound() {
    print("$name says Woof");
  }
}
