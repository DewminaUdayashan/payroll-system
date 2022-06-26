extension StringExtentions on String {
  String toFirstLetterUpper() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension IntExtentions on int {
  String toRoleName() {
    switch (this) {
      case 1:
        return "Administrator";
      case 2:
        return "Local User";
      case 3:
        return "Guest";
      default:
        return "";
    }
  }
}
