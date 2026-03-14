extension MapStringExtension on Map<String, dynamic> {
  String getString(String key) {
    final value = this[key];
    if (value is String) {
      return value;
    } else {
      throw Exception('Value for key "$key" is not a String.');
    }
  }

  int getInt(String key) {
    final value = this[key];
    if (value is int) {
      return value;
    } else {
      throw Exception('Value for key "$key" is not an int.');
    }
  }

  double getDouble(String key) {
    final value = this[key];
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else {
      throw Exception('Value for key "$key" is not a double.');
    }
  }

  bool getBool(String key) {
    final value = this[key];
    if (value is bool) {
      return value;
    } else {
      throw Exception('Value for key "$key" is not a bool.');
    }
  }

  Map<String, dynamic> getMap(String key) {
    final value = this[key];
    if (value is Map<String, dynamic>) {
      return value;
    } else {
      throw Exception('Value for key "$key" is not a Map<String, dynamic>.');
    }
  }

  List<T> getList<T>(
    String key, [
    T Function(Map<String, dynamic> value)? parser,
  ]) {
    final value = this[key];
    if (value is List) {
      if (parser != null) {
        return value
            .map((item) => parser(item as Map<String, dynamic>))
            .toList();
      } else {
        return List<T>.from(value);
      }
    } else {
      throw Exception('Value for key "$key" is not a List.');
    }
  }
}
