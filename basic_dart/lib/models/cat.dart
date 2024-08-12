import 'package:basic_dart/models/animal.dart';

class Cat extends Animal {
  Cat(super.name);

  @override
  void makeSound() {
    print("$name says Meow");
  }
}
