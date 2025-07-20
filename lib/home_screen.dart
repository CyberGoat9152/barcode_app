import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? barcodeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escaneador de Barcode')),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? code = barcodes.first.rawValue;
                if (code != null && code != barcodeData) {
                  setState(() {
                    barcodeData = code;
                  });
                  _mostrarDialogo(context, code);
                }
              }
            },
          ),

          if (barcodeData != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Último código: $barcodeData',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _mostrarDialogo(BuildContext context, String code) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Código detectado'),
        content: Text(code),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
