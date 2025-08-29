import 'package:digitalsaathi/ui/more/chat_screen/chatModel/chat_message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  final String userId;

  SocketService({required this.userId});

  void connect() {
    socket = IO.io(
      'SERVER_IP',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    socket.onConnect((_) {
      print('-------------Connected-------------------');
      socket.emit('register_user', {'userId': userId});
    });

    socket.onDisconnect((_) => print('--------------------------Disconnected-------------------------------'));
  }

  void sendMessage(ChatMessageModel message) {
    socket.emit('send_message', message.toJson());
  }

  void onMessageReceived(Function(ChatMessageModel) onReceive) {
    socket.on('receive_message', (data) {
      onReceive(ChatMessageModel.fromJson({
        ...data,
        'timestamp': DateTime.now().toIso8601String()
      }));
    });
  }

  void dispose() {
    socket.disconnect();
  }
}


