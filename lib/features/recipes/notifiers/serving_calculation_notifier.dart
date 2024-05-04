import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServingCalculationNotifier extends StateNotifier<int> {
  ServingCalculationNotifier() : super(1);

  int realServingCount = 0;

  // Future<void> setRealServingCount(int count) async {
  //   realServingCount = count;
  //   await Future.delayed(const Duration(milliseconds: 100), () {
  //     state = count;
  //   });
  // }

  void setRealServingCount(int count) {
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   state = count;
    //   realServingCount = count;
    // });
    realServingCount = 0;
    realServingCount = count;
  }

  void addServingCount(int i) {
    int newCount = state + 1;
    state = newCount;
  }

  void removeServingCount(int i) {
    if (state == 1) {
      return;
    }
    int newCount = state - 1;
    state = newCount;
  }

  void updateServingCount(int count) {
    state = count;
  }

  double getUpdatedIngredientAmount(double amount) {
    return (amount / realServingCount) * state;
  }
}
// -----------------------------------------------------------------------------

final servingCalculationProvider =
    StateNotifierProvider<ServingCalculationNotifier, int>((ref) {
  return ServingCalculationNotifier();
});
