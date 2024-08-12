abstract class Animal {
  String _name;

  Animal(this._name);

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  void makeSound();
}
