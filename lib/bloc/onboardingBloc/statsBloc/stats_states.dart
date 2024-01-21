abstract class StatsStates {}

class StatButtonSelectedStates extends StatsStates {
  int index = 0;
  StatButtonSelectedStates(this.index);
}

class StatButtonUnselectedStates extends StatsStates {}
