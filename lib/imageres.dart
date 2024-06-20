class ImageRes{

  // this expression here makes the class private and it further doest allows to define this class's constructor again
  ImageRes._();

  // creating the base common url for all the icon files..
  static const String _imageBase = "assets/images";
  static const String _iconBase = "assets/icons";


  ///ImageSources
  static const String highTemp= "$_imageBase/celsiusimage.png";
  static const String  lowTemp= "$_imageBase/mintemp.png";
  static const String  pressureImage= "$_imageBase/pressuregauge.png";
  static const String  humidityImage= "$_imageBase/humidity.png";
  static const String  sunRiseImage= "$_imageBase/sunrise.png";
  static const String  sunSetImage= "$_imageBase/sunset.png";
  static const String  sunnyDayImage= "$_imageBase/sunnyday.png";
  static const String  lightRainyDayImage= "$_imageBase/lightrain.png";
  static const String cancelIcon= "$_imageBase/close.png";
  static const String countryIcon= "$_imageBase/countries.png";
  static const String submitIcon= "$_imageBase/submit.png";


  ///Icon Sources
  static const String questionIcon= "$_iconBase/questionicon.png";

}