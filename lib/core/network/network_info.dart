// import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

// /// we have created contract class even fot this
// /// so if we decide to change the [DataConnectionChecker] package
// /// it will not afftec for the many cases
// /// you only have to change the [NetworkInfoImpl] class
// abstract class NetworkInfo {
//   Future<bool> get isConnected;
// }

// class NetworkInfoImpl extends NetworkInfo {
//   final DataConnectionChecker connChecker;

//   NetworkInfoImpl(this.connChecker);
//   @override
//   Future<bool> get isConnected => connChecker.hasConnection;
// }
