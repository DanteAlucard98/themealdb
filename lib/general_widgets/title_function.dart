//Clase para convertir el texto a title case

String titleCase(String? text) {
  if (text == null) throw ArgumentError("string: $text");

  if (text.isEmpty) return text;

  return text
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}