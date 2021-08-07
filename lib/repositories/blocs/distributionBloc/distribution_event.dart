part of 'distribution_bloc.dart';

abstract class DistributionEvent extends Equatable {
  const DistributionEvent();

  @override
  List<Object> get props => [];
}

class DistributionEmailChanged extends DistributionEvent {
  final String email;

  DistributionEmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class DistributionNameChanged extends DistributionEvent {
  final String name;

  DistributionNameChanged({this.name});

  @override
  List<Object> get props => [name];
}


class DistributionSubmitted extends DistributionEvent {
  final String email;
  final String name;
  final String language;

  DistributionSubmitted({this.email, this.name, this.language});

  @override
  List<Object> get props => [email, name, language];
}
