import 'dart:developer';
import 'package:nfc_manager/nfc_manager.dart';


enum NFCErrorType {
  notSupported,
  unavailable,
  sessionError,
  tagReadError,
  tagWriteError,
}

class NFCService {
  /// Singleton pattern
  NFCService._internal();
  static final NFCService instance = NFCService._internal();

  /// Check NFC availability
  Future<bool> isAvailable() async {
    try {
      return await NfcManager.instance.isAvailable();
    } catch (e) {
      log("NFC Availability Error: $e");
      return false;
    }
  }

  /// Start reading NFC tag
  Future<void> startReading({
    required Function(String) onTagRead,
    required Function(NFCErrorType, String) onError,
  }) async {
    try {
      bool available = await isAvailable();
      if (!available) {
        onError(NFCErrorType.unavailable, "NFC not available on this device");
        return;
      }

      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          try {
            final ndef = Ndef.from(tag);
            if (ndef == null) {
              onError(NFCErrorType.tagReadError, "Non-NDEF tag detected");
              return;
            }

            final cachedMessage = ndef.cachedMessage;
            if (cachedMessage != null && cachedMessage.records.isNotEmpty) {
              final record = cachedMessage.records.first;
              final payload = String.fromCharCodes(record.payload);
              onTagRead(payload);
            } else {
              onError(NFCErrorType.tagReadError, "Empty NFC tag");
            }
          } catch (e) {
            onError(NFCErrorType.tagReadError, e.toString());
          }
        },
      );
    } catch (e) {
      onError(NFCErrorType.sessionError, e.toString());
    }
  }

  /// Write to NFC tag
  Future<void> writeTag({
    required String message,
    required Function(String) onSuccess,
    required Function(NFCErrorType, String) onError,
  }) async {
    try {
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          try {
            final ndef = Ndef.from(tag);
            if (ndef == null || !ndef.isWritable) {
              onError(NFCErrorType.tagWriteError, "Tag not writable");
              return;
            }

            final record = NdefRecord.createText(message);
            final ndefMessage = NdefMessage([record]);
            await ndef.write(ndefMessage);

            onSuccess("Message written successfully: $message");
            stopSession();
          } catch (e) {
            onError(NFCErrorType.tagWriteError, e.toString());
          }
        },
      );
    } catch (e) {
      onError(NFCErrorType.sessionError, e.toString());
    }
  }

  /// Stop NFC session
  void stopSession() {
    try {
      NfcManager.instance.stopSession();
    } catch (e) {
      log("Error stopping NFC session: $e");
    }
  }
}
