class Bid{
  final double amount;
  final String jobId;
  ///handyman
  final String handymanId;
  final String customerId;
  final bool accepted;
  final bool rejected;
  final String id;

  const Bid({
    required this.amount,
    required this.jobId,
    required this.handymanId,
    required this.customerId,
    required this.accepted,
    required this.rejected,
    required this.id
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'jobId': jobId,
      'handymanId': handymanId,
      'customerId': customerId,
      'accepted': accepted,
      'rejected': rejected,
      'id' : id,
    };
  }

  factory Bid.fromMap(Map<String, dynamic> map) {
    return Bid(
      amount: map['amount'] as double,
      jobId: map['jobId'] as String,
      handymanId: map['handymanId'] ,
      customerId: map['customerId'] ,
      accepted: map['accepted'] as bool,
      rejected: map['rejected'] as bool,
      id: map['id']

    );
  }
}