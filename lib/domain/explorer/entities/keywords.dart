import 'package:equatable/equatable.dart';

class Keywords extends Equatable {
  final int id;
  final String word;
  Keywords({
    required this.id,
    required this.word,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, word];
}
