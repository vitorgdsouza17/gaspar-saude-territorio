import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);

void main() => runApp(const GasparApp());

class GasparApp extends StatelessWidget {
  const GasparApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Gaspar Saúde Território',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF20851B)),
      useMaterial3: true,
    ),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> familias;

  @override
  void initState() {
    super.initState();
    atualizar();
  }

  void atualizar() {
    setState(() {
      familias = http
          .get(Uri.parse('$apiBaseUrl/api/v1/familias'))
          .timeout(const Duration(seconds: 8))
          .then((response) {
        if (response.statusCode != 200) {
          throw Exception('Erro HTTP ' + response.statusCode.toString());
        }
        return (jsonDecode(response.body) as Map<String, dynamic>)['items']
            as List<dynamic>;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Gaspar Saúde Território'),
      backgroundColor: const Color(0xFF20851B),
      foregroundColor: Colors.white,
    ),
    body: RefreshIndicator(
      onRefresh: () async {
        atualizar();
        try {
          await familias;
        } catch (_) {
          // O FutureBuilder apresenta falhas de conexão.
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFFE7F5E5),
            child: const Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Olá, ACS!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('Microárea 07 · Wagner/BA'),
                  SizedBox(height: 10),
                  Text('AMBIENTE DE DEMONSTRAÇÃO · DADOS FICTÍCIOS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Famílias cadastradas', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FutureBuilder<List<dynamic>>(
            future: familias,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      const Text('Não foi possível conectar à API local.'),
                      const SizedBox(height: 6),
                      Text(snapshot.error.toString(), style: const TextStyle(fontSize: 12)),
                      TextButton(onPressed: atualizar, child: const Text('Tentar novamente')),
                    ]),
                  ),
                );
              }
              final items = snapshot.data ?? [];
              if (items.isEmpty) return const Text('Nenhuma família encontrada.');
              return Column(
                children: items.map((raw) {
                  final f = raw as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.home_outlined)),
                      title: Text(f['responsavel'].toString()),
                      subtitle: Text(f['domicilio'].toString()),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(f['pendencias'].toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          const Text('pendências', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text('Sincronização PEC: desativada nesta versão.', textAlign: TextAlign.center),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: atualizar,
      tooltip: 'Atualizar famílias',
      child: const Icon(Icons.refresh),
    ),
  );
}
