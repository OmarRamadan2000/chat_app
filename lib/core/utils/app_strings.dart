class AppStrings {
  static const String regexpEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const String regexpPass =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const String regexpNameEn =
      r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
  static const String regexpPhone = r'(^(?:[+0]9)?[0-9]{11}$)';
  static String uId = '';
  static const List<String> settings = [
    'Language',
    'Notifications',
    'Appearance',
    'Help & Support'
  ];
}
