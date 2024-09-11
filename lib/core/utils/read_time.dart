int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'|s+')).length;
  final readTime = (wordCount ~/ 225);
  return readTime;
}
