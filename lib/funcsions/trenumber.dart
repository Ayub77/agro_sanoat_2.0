class TreeNumber {
  static String toProcessCost(String value) {
    if (value == '0') {
      return '0';
    }
    bool real = false;
    String valueRealPart = '';
    String nol = "";
    if (value.indexOf('.') > 0) {
      real = true;
      valueRealPart = value.substring(value.indexOf('.'), value.length);
      value = value.substring(0, value.indexOf('.'));
      if (valueRealPart.length > 4) {
        nol = valueRealPart.substring(0, 3);
      } else {
        nol = valueRealPart;
      }
    }
    String count = '';
    if (value.length > 3) {
      int a = 0;
      for (int i = value.length; 0 < i; i--) {
        if (a % 3 == 0) {
          count = value.substring(i - 1, i) + ' ' + count;
        } else {
          count = value.substring(i - 1, i) + count;
        }
        a++;
      }
    } else {
      count = value;
    }
    return count + nol;
  }
}
