
class Comt {
  String Uid;
  String Comment;

  Comt({
    required this.Uid,
    required this.Comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'Uid': Uid,
      'Comment': Comment,
    };
  }

  factory Comt.fromMap(Map<String, dynamic> map) {
    return Comt(
      Uid: map['Uid'] as String,
      Comment: map['Comment'] as String,
    );
  }
}