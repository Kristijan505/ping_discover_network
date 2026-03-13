import 'package:flutter_test/flutter_test.dart';
import 'package:ping_discover_network/ping_discover_network.dart';

void main() {
  group('NetworkAnalyzer port validation', () {
    test('discover emits ArgumentError for port below range', () async {
      await expectLater(
        NetworkAnalyzer.discover('192.168.0', 0),
        emitsError(isA<ArgumentError>()),
      );
    });

    test('discover emits ArgumentError for port above range', () async {
      await expectLater(
        NetworkAnalyzer.discover('192.168.0', 65536),
        emitsError(isA<ArgumentError>()),
      );
    });

    test('discover2 throws ArgumentError for port below range', () {
      expect(
        () => NetworkAnalyzer.discover2('192.168.0', 0),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('discover2 throws ArgumentError for port above range', () {
      expect(
        () => NetworkAnalyzer.discover2('192.168.0', 65536),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  test('discover2 stream completes for a valid subnet', () async {
    final Stream<NetworkAddress> stream = NetworkAnalyzer.discover2(
      '127.0.0',
      9,
      timeout: const Duration(milliseconds: 20),
    );

    await expectLater(
      stream.drain<void>().timeout(const Duration(seconds: 10)),
      completes,
    );
  });
}
