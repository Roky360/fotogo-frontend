import 'package:bloc/bloc.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/fotogo_protocol/networking_protocol.dart';
import 'package:meta/meta.dart';

part 'server_event.dart';
part 'server_state.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  final Client client;

  ServerBloc(this.client) : super(const ServerInitial()) {
    on<FetchDataEvent>((event, emit) async {
      // final Response? res = await client.createConnection(event.request);
      // emit(ServerGotData(res!));
    });
  }
}
