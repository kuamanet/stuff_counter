import 'package:flutter_test/flutter_test.dart';
import 'package:stuff_counter/counters/entities/counter_read_dto.dart';

import '../test_utils.dart';

void main() {
  test("it can be transformed into a Map<string, object?>", () {
    final counter = readEmptyCounter();

    final hash = counter.toMap();

    expect(hash["id"], counter.id);
    expect(hash["count"], counter.count);
    expect(hash["name"], counter.name);
    expect(hash["color"], counter.color);
    expect(hash["history"], counter.history.map((e) => e.toMap()));

    expect(hash["history"] is List<Map<String, Object?>>, true,
        reason: "history is of type ${hash["history"].runtimeType}");
  });
  test("it can be created from a Map<string, object?>", () {
    final counter = readEmptyCounter();

    final parsed = CounterReadDto.from({
      "count": counter.count,
      "name": counter.name,
      "color": counter.color,
      "history": counter.history.map((e) => e.toMap()).toList(),
    }, counter.id);

    expect(parsed, equals(counter));
  });
}
