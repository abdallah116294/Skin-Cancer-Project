class PaymentResponse {
  final String sessionId;
  final String publishKey;
  final String url;

  PaymentResponse({
    required this.sessionId,
    required this.publishKey,
    required this.url,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      sessionId: json['sessionId'],
      publishKey: json['publishKey'],
      url: json['url'],
    );
  }
}
