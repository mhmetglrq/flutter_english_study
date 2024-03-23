enum ImageConstants {
  authBg("auth_bg"),
  ;

  final String value;
  const ImageConstants(this.value);

  String get getPng => 'assets/images/$value.png';
  String get getJpg => 'assets/images/$value.jpg';
}
