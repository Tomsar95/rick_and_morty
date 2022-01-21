import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/Utils/characters_colors.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/widgets.dart';

import '../../../../injection_container.dart';

// class CharactersPage extends StatelessWidget {
//   late  CharactersBloc charactersBloc;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text('Number Trivia Generator')),
//         backgroundColor: CharactersColors.darkBlue,
//       ),
//       body: buildBody(context),
//     );
//   }
//   BlocProvider<CharactersBloc> buildBody(BuildContext context) {
//     return BlocProvider(
//       create: (_) => serviceLocator<CharactersBloc>(),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               const SizedBox(height: 10),
//               BlocBuilder<CharactersBloc, CharactersState>(
//                 builder: (context, state) {
//                   if (state is LoadingCharactersState) {
//                     context.read<CharactersBloc>().add(GetCharactersEvent());
//                     return const LoadingWidget();
//                   } else if (state is LoadedCharactersState) {
//                     return CharactersScroll(characters: state.characters);
//                   } else if (state is ErrorCharactersState) {
//                     return MessageDisplay(message: state.message);
//                   }
//                   return SizedBox(
//                     height: MediaQuery.of(context).size.height / 3,
//                     child: const Placeholder(),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Number Trivia Generator')),
        backgroundColor: CharactersColors.darkBlue,
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<CharactersBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<CharactersBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            if (state is LoadingCharactersState) {
              context.read<CharactersBloc>().add(GetCharactersEvent());
              return const LoadingWidget();
            } else if (state is LoadedCharactersState) {
              return CharactersScroll(characters: state.characters);
            } else if (state is ErrorCharactersState) {
              return MessageDisplay(message: state.message);
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: const Placeholder(),
            );
          },
        ),
      ),
    );
  }
}

