/// A single item of work, with no parameters
abstract class Action<TValue> {
  Future<TValue> run();
}

/// A single item of work as a stream, with no parameters
abstract class StreamAction<TValue> {
  Stream<TValue> run();
}

/// A single item of work, with parameters
abstract class ParamsAction<TParams, TValue> {
  Future<TValue> run(TParams params);
}

/// A single item of work as a stream, with parameters
abstract class ParamsStreamAction<TParams, TValue> {
  Stream<TValue> run(TParams params);
}
