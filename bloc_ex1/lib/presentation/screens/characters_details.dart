import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_ex1/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_ex1/constants/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/characters.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _charactersInfo(
                          'Job : ', character.occupation.join(' / ')),
                      _buildDivider(MediaQuery.of(context).size.width * 0.78),
                      _charactersInfo('Appeared in : ', character.category),
                      _buildDivider(MediaQuery.of(context).size.width * 0.605),
                      _charactersInfo(
                          'Seasons : ', character.appearance.join(' / ')),
                      _buildDivider(MediaQuery.of(context).size.width * 0.68),
                      _charactersInfo('Status : ', character.status),
                      _buildDivider(MediaQuery.of(context).size.width * 0.73),
                      _charactersInfo('Birthday : ', character.birthday),
                      _buildDivider(MediaQuery.of(context).size.width * 0.68),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : _charactersInfo('Better Call Saul Seasons : ',
                              character.betterCallSaulAppearance.join(' / ')),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : _buildDivider(
                              MediaQuery.of(context).size.width * 0.31),
                      _charactersInfo('Actor/Actress : ', character.portrayed),
                      _buildDivider(MediaQuery.of(context).size.width * 0.56),
                      const SizedBox(
                        height: 40,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                          builder: (context, state) =>
                              _buildTextRandomQuotes(state))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.65,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname,
          style: const TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _charactersInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: MyColors.myWhite, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 25,
      thickness: 2,
      endIndent: endIndent,
    );
  }

  Widget _buildTextRandomQuotes(CharactersState state) {
    if (state is CharactersQuoteLoaded) {
      return _displayRandomQuotesOrEmptySpace(state);
    } else {
      return _showProgressIndicator();
    }
  }

  Widget _displayRandomQuotesOrEmptySpace(CharactersQuoteLoaded state) {
    var quotes = (state).quote;
    if (quotes.isNotEmpty) {
      var randomQuotesIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 20,
            shadows: [
              Shadow(
                color: MyColors.myYellow,
                offset: Offset(0, 0),
                blurRadius: 7,
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(
                quotes[randomQuotesIndex].quote,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),

    );
  }
}
