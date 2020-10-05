class HttpConstants {
  static const int success = 200;
  static const int createSuccess = 201;
  static const int redirect = 302;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int cartDataException = 406;
  static const int serverError = 500;

  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String jsonContentType = 'application/json';
  static const String formUrlEncodedType = 'application/x-www-form-urlencoded';
  static const String multipartFormDataType = 'multipart/form-data';
}
