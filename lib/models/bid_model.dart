class Bid{
  final double amount;
  final String jobId;
  ///handyman
  final double handymanId;
  final double customerId;
  final bool accepted;
  final bool rejected;

  const Bid({
    required this.amount,
    required this.jobId,
    required this.handymanId,
    required this.customerId,
    required this.accepted,
    required this.rejected,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'jobId': jobId,
      'handymanId': handymanId,
      'customerId': customerId,
      'accepted': accepted,
      'rejected': rejected,
    };
  }

  factory Bid.fromMap(Map<String, dynamic> map) {
    return Bid(
      amount: map['amount'] as double,
      jobId: map['jobId'] as String,
      handymanId: map['handymanId'] as double,
      customerId: map['customerId'] as double,
      accepted: map['accepted'] as bool,
      rejected: map['rejected'] as bool,
    );
  }
}