dynamic formatFindrobeCollection({required dynamic category}) {
  String convert = category.toString();
  List<dynamic> parts = convert.split(".");
  dynamic result = parts[1].toLowerCase();
  dynamic capital = result[0].toUpperCase() + result.substring(1);

  return capital;
}