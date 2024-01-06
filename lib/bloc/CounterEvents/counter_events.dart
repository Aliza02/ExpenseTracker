abstract class CounterEvents {}

class IncrementEvent extends CounterEvents {
  int counter;
  IncrementEvent(this.counter);
}

class DecrementEvent extends CounterEvents {
  int counter;
  DecrementEvent(this.counter);
}
