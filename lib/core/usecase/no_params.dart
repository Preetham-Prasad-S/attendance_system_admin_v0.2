class NoParams {
  const NoParams();

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'NoParams';
}