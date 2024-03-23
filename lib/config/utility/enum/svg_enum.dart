enum SvgConstants {
  eyeOpen("eye_open"),
  eyeClose("eye_close"),
  group("group"),
  ;

  final String value;
  const SvgConstants(this.value);

  String get getSvg => 'assets/svg/$value.svg';
}
