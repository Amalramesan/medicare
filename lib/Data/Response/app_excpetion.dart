class AppExpection implements Exception {
  final String? _message;
  final String?_prefix;
  AppExpection([this._message, this._prefix]);
@override
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
