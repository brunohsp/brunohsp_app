
class Calculate {
  static double widthWithColumns(int columns, double deviceWidht) {
    return columns * (deviceWidht / 4) - 16 * (columns);
  }
}
