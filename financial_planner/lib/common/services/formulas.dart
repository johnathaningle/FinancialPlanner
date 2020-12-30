import 'dart:math';

class Formulas {
  /**
   * p = principal
   * t = number of years
   * n = number of times the value is compounded per year
   * r = the rate of interest ex: 0.08
   */
  static double compoundInterest(double p, int t, int n, double r) {
    return p * pow((1 + (r / n)), (n * t));
  }
}
