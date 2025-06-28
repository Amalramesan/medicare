class AppExpection implements Exception {
  final _message;
  final _prefix;
  AppExpection([this._message, this._prefix]);

  String toString() {
    return '$_message$_prefix';
  }
}

class FectchDataExpection extends AppExpection {
  FectchDataExpection([String? message])
    : super(message, 'Error during communication');
}

class BadRequestExpection extends AppExpection {
  BadRequestExpection([String? message]) : super(message, 'Invalid Request');
}

class UnauthorizedExpection extends AppExpection {
  UnauthorizedExpection([String? message])
    : super(message, 'Unauthorized Request');
}

class InvalidExpection extends AppExpection {
  InvalidExpection([String? message]) : super(message, 'Unauthorized Request');
}
