class RequestResult {
  bool status;
  String? title;
  String? message;

  RequestResult({
    required this.status,
    this.title,
    this.message,
  });
}
