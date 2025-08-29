import 'package:flutter/material.dart';
import 'nfc_services.dart';

class NFCPage extends StatefulWidget {
  const NFCPage({super.key});

  @override
  State<NFCPage> createState() => _NFCPageState();
}

class _NFCPageState extends State<NFCPage> {
  String status = "Ready to scan/write NFC tag";

  void _startScan() {
    NFCService.instance.startReading(
      onTagRead: (data) {
        setState(() {
          status = "Tag Data: $data";
        });
      },
      onError: (type, message) {
        setState(() {
          status = "Error [$type]: $message";
        });
      },
    );
  }

  void _writeTag() {
    NFCService.instance.writeTag(
      message: "Hello from Flutter 🚀",
      onSuccess: (msg) {
        setState(() {
          status = msg;
        });
      },
      onError: (type, message) {
        setState(() {
          status = "Write Error [$type]: $message";
        });
      },
    );
  }

  void _stopScan() {
    NFCService.instance.stopSession();
    setState(() {
      status = "Session stopped";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NFC Example (Senior Level)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _startScan, child: const Text("Start Scanning")),
            ElevatedButton(onPressed: _writeTag, child: const Text("Write Tag")),
            ElevatedButton(onPressed: _stopScan, child: const Text("Stop Session")),
          ],
        ),
      ),
    );
  }
}
