import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/core_widgets.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/character/character_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/concrete_character_widget.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/widgets.dart';
import 'package:rick_and_morty/injection_container.dart';

class ConcreteCharacterPage extends StatelessWidget {

  final int characterId;

  const ConcreteCharacterPage({Key? key, required this.characterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoreWidgets.charactersAppBar(context),
      body: buildBody(context),
    );
  }

  BlocProvider<CharacterBloc> buildBody(BuildContext context) {
    return BlocProvider(create: (_) => serviceLocator<CharacterBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<CharacterBloc, CharacterState>(
                builder: (context, state) {
                  if (state is LoadingCharacterState) {
                    context.read<CharacterBloc>().add(GetConcreteCharacterEvent(characterId));
                    return const LoadingWidget();
                  } else if (state is LoadedCharacterState) {
                    return ConcreteCharacterWidget(character: state.character);
                  } else if (state is ErrorCharacterState) {
                    return MessageDisplay(message: state.message);
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const Placeholder(),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
