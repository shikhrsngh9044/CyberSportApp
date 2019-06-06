class OtpResponse {
  final String message;
  final String otp;

  OtpResponse({this.message, this.otp});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(message: json['message'], otp: json['otp']);
  }
}
