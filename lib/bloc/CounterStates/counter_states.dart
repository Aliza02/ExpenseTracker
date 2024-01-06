abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class IncrementState extends CounterStates {
  int counter;
  IncrementState(this.counter);
}

class DecrementState extends CounterStates {
  int counter;
  DecrementState(this.counter);
}
