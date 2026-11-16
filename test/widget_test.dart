import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kosfinder_mini/main.dart';

void main() {
  testWidgets('menampilkan enam data kos', (WidgetTester tester) async {
    await tester.pumpWidget(const KosFinderMini());

    expect(find.text('KosFinder Mini'), findsOneWidget);
    expect(find.text('Kos Melati'), findsOneWidget);
    expect(find.text('Singaraja • Rp 750.000/bulan'), findsOneWidget);
    expect(find.text('Kos Kenanga'), findsOneWidget);
    expect(find.text('Kos Cempaka'), findsOneWidget);
    expect(find.text('Kos Anggrek'), findsOneWidget);
    expect(find.text('Kos Mawar'), findsOneWidget);
    expect(find.text('Kos Teratai'), findsOneWidget);
  });

  testWidgets('pencarian tidak peka huruf besar dan dapat dihapus', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KosFinderMini());

    await tester.enterText(find.byType(TextField), '  MELATI  ');
    await tester.pump();

    expect(find.text('Kos Melati'), findsOneWidget);
    expect(find.text('Kos Kenanga'), findsNothing);
    expect(find.byIcon(Icons.clear), findsOneWidget);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();

    expect(find.text('Kos Teratai'), findsOneWidget);
  });

  testWidgets('tombol favorit mengubah ikon hati', (WidgetTester tester) async {
    await tester.pumpWidget(const KosFinderMini());

    expect(find.byIcon(Icons.favorite_border), findsNWidgets(6));
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
