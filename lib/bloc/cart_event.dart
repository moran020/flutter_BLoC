class CartEvent {}

class Add extends CartEvent {
  int index;
  Add({required this.index});
}

class Remove extends CartEvent {
  int index;
  Remove({required this.index});
}
