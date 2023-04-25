class SubscriptionRequest {
  final String email;
  final bool allowAccess;
  final String subscriptionType;
  const SubscriptionRequest({
    required this.email,
    required this.subscriptionType,
    required this.allowAccess,
  });
  Map<String, Object> toFirebaseObject() {
    return {
      'email': email,
      'subscriptionType': subscriptionType,
      'allowAccess': allowAccess,
    };
  }

  factory SubscriptionRequest.fromFirebase(
      Map<String, dynamic>? firebaseSubscriptionRequest) {
    String email = firebaseSubscriptionRequest!['email'];
    String subscriptionType = firebaseSubscriptionRequest['subscriptionType'];
    bool allowAccess = firebaseSubscriptionRequest['allowAccess'];

    return SubscriptionRequest(
      email: email,
      subscriptionType: subscriptionType,
      allowAccess: allowAccess,
    );
  }
}
