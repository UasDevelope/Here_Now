class Images {
  static String get logo => "logo".png;
  static String get signup => 'signup'.png;
  static String get login => 'login'.png;
  static String get home => 'home'.png;
  static String get event => 'event'.png;
  static String get post => 'post'.png;
  static String get institue => 'institute'.png;
  static String get search => 'search'.png;
  static String get setting => 'setting'.png;
  static String get person => 'person'.png;
  static String get posts => 'posts'.png;
  static String get thumb => 'thumb'.png;
  static String get star => 'star'.png;
  static String get pin => 'pin'.png;
  static String get phone => 'phone'.png;
  static String get money => 'money'.png;
  static String get rating => 'rating'.png;
  static String get share => 'share'.png;
  static String get addimage => 'addimage'.png;
  static String get mail => 'mail'.png;
  static String get edit=>'edit'.png;
  static String get logout=>'logout'.png;
}

extension on String {
  String get png => "assets/images/$this.png";
}
