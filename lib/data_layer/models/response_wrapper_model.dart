//------------------------------------The Error  Wrapper ---------------------

class ErrorWrapper {
  final String error;
  final String message;

  const ErrorWrapper({required this.error, required this.message});

  @override
  String toString() => message;
}

//------------------------------- The Whole Response Wrapper Model --------------------
class ResponseWrapperModel {
  final bool isSucceeded;
  final int statusCode;
  final dynamic responseBody;
  final ErrorWrapper? error;
  final List<dynamic>? arguments;

  const ResponseWrapperModel({
    required this.isSucceeded,
    required this.statusCode,
    this.responseBody,
    this.error,
    this.arguments,
  });
  const ResponseWrapperModel.success({required this.responseBody})
      : statusCode = 200,
        isSucceeded = true,
        error = null,
        arguments = null;

//to have the responseBody only:
  anyReceivedDataType unwrap<anyReceivedDataType>() =>
      responseBody as anyReceivedDataType;
}
