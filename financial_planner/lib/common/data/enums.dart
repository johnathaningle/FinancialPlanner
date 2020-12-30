enum GenderType {
  Male,
  Female,
  Unknown,
}

enum Mortality {
  Poor,
  Average,
  Good,
}

enum Frequency {
  Weekly,
  BiWeekly,
  TwiceMonthly,
  Monthly,
  Annually,
}

// how negotiable is this expense?
// this will be used when making recommendations for budget optimisations
enum Necessity {
  Critical, // this expense cannot be removed and is difficult to reduce
  Adjustable, // this needs to stick around but there's some wiggle room on cost
  Expendable, // worst case scenario, I can drop this expense
}
