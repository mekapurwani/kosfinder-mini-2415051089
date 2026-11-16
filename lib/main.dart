import 'package:flutter/material.dart';

void main() => runApp(const KosFinderMini());

class Kos {
  const Kos(this.nama, this.lokasi, this.harga);
  final String nama;
  final String lokasi;
  final int harga;
}

class KosFinderMini extends StatelessWidget {
  const KosFinderMini({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KosFinder Mini',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const KosListPage(),
    );
  }
}

class KosListPage extends StatefulWidget {
  const KosListPage({super.key});

  @override
  State<KosListPage> createState() => _KosListPageState();
}

class _KosListPageState extends State<KosListPage> {
  final daftar = const [
    Kos('Kos Melati', 'Singaraja', 750000),
    Kos('Kos Kenanga', 'Sukasada', 650000),
    Kos('Kos Cempaka', 'Singaraja', 850000),
    Kos('Kos Anggrek', 'Bauleleng', 700000),
    Kos('Kos Mawar', 'Singaraja', 950000),
    Kos('Kos Teratai', 'Sukasada', 600000),
  ];

  String pencarian = '';
  final Set<String> favorit = {};

  @override
  Widget build(BuildContext context) {
    final hasil = daftar
        .where((kos) =>
            kos.nama.toLowerCase().contains(pencarian.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('KosFinder Mini')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Cari nama kos',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (teks) => setState(() => pencarian = teks),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: hasil.isEmpty
                  ? const Center(child: Text('Kos tidak ditemukan'))
                  : ListView.builder(
                      itemCount: hasil.length,
                      itemBuilder: (context, index) {
                        final kos = hasil[index];
                        final disukai = favorit.contains(kos.nama);

                        return Card(
                          child: ListTile(
                            title: Text(kos.nama),
                            subtitle: Text('${kos.lokasi} • Rp${kos.harga}/bulan'),
                            trailing: IconButton(
                              icon: Icon(disukai
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              color: disukai ? Colors.red : null,
                              onPressed: () => setState(() {
                                if (disukai) {
                                  favorit.remove(kos.nama);
                                } else {
                                  favorit.add(kos.nama);
                                }
                              }),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}