extension DiacriticsAwareString on String {
  String withoutDiacriticalMarks() {
    const diacritics = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏİìíîïÙÚÛÜùúûüÑñŠšŸÿýŽžıŞşĞğ';
    const nonDiacritics = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiiUUUUuuuuNnSsYyyZziSsGg';

    return splitMapJoin(
      '',
      onNonMatch: (char) =>
          char.isNotEmpty && diacritics.contains(char) ? nonDiacritics[diacritics.indexOf(char)] : char,
    );
  }
}
