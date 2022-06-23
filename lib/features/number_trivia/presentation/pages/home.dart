// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../blocs/bloc/number_trivia_bloc.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late TextEditingController textEditingController;

//   @override
//   void initState() {
//     super.initState();
//     textEditingController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
//         builder: (context, state) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (state is Empty) const Text('Enter Number or Get Random'),
//               if (state is Loading) const Text('Loading...'),
//               if (state is Loaded) Text(state.trivia.text),
//               if (state is Error) Text('Error : ${state.message}'),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: textEditingController,
//                   decoration: const InputDecoration(labelText: 'Enter Number'),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       context.read<NumberTriviaBloc>().add(
//                           GetTriviaConcreteNumber(textEditingController.text));
//                     },
//                     child: const Text('Search'),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       context
//                           .read<NumberTriviaBloc>()
//                           .add(GetTriviaRandomNumber());
//                     },
//                     child: const Text('Random'),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
