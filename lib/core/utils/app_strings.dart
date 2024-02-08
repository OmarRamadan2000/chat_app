class AppStrings {
  static const String regexpEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static const String regexpPass =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const String regexpNameEn =
      r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
  static const String regexpPhone = r'(^(?:[+0]9)?[0-9]{11}$)';
  static String uId = '';
  static String userImage =
      'https://firebasestorage.googleapis.com/v0/b/chat-app-27b8d.appspot.com/o/images%2F240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg?alt=media&token=ffb86ec0-c74b-47e1-9a0f-e7ebce748817';
  static const List<String> settings = [
    'Language',
    'Notifications',
    'Appearance',
    'Help & Support'
  ];
}
