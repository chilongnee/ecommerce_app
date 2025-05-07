class ResultModel<T> {
  final bool success;
  final String? message;
  final T? data;

  ResultModel({
    required this.success,
    this.message,
    this.data,
  });
}