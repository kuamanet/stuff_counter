import 'package:flutter_test/flutter_test.dart';
import 'package:stuff_counter/counters/actions/generate_random_color.dart';

void main() {
  test("It returns a random color", () async {
    final action = GenerateRandomColor();

    var color1 = await action.run();
    var color2 = await action.run();

    expect(color1, isNot(equals(color2)));
  });
}
