class MFRecurringType<String> {
  Type? type;
  int? days;

  MFRecurringType(Type type, int days) {
    this.type = type;
    this.days = days;
  }

  static MFRecurringType daily = new MFRecurringType(Type.DAILY, 0);

  static MFRecurringType weekly = new MFRecurringType(Type.WEEKLY, 0);

  static MFRecurringType monthly = new MFRecurringType(Type.MONTHLY, 0);

  static MFRecurringType custom(int days) {
    return new MFRecurringType(Type.CUSTOM, days);
  }
}

enum Type { DAILY, WEEKLY, MONTHLY, CUSTOM }
