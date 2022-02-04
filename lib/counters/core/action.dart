/// A single item of work, with no parameters
abstract class Action<TValue> {
  Future<TValue> run();
}

abstract class StreamAction<TValue> {
  Stream<TValue> run();
}

/// A single item of work, with parameters
abstract class ParamsAction<TParams, TValue> {
  Future<TValue> run(TParams params);
}
