class ReviewModel{
  String name;
  String review;
  double rating;
  ReviewModel({required this.name, required this.review,required this.rating});

  factory ReviewModel.fromJson(Map<String, dynamic> json){
    return ReviewModel(
      name: json['name'],
      review: json['review'],
      rating: json['rating']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'review': review,
      'rating': rating
    };
  }
}