import 'package:bloc_ex1/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_ex1/constants/mycolors.dart';
import 'package:bloc_ex1/presentation/widgets/characters_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../data/models/characters.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character> allCharacters = [];
  late List<Character> _searchedForCharacters;
  bool _isSearch = false;

  final TextEditingController _searchEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget _buildSearchFaild() {
    return TextFormField(
      controller: _searchEditingController,
      cursorColor: MyColors.myGrey,
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      decoration: const InputDecoration(
        hintText: 'Find a Characters...',
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
        border: InputBorder.none,
      ),
      onChanged: (searched) {
        addSearchForItemsToSearchedList(searched);
      },
    );
  }

  addSearchForItemsToSearchedList(String searched) {
    _searchedForCharacters = allCharacters
        .where((character) => character.name.toLowerCase().startsWith(searched))
        .toList();
    setState(() {});
  }

  List<Widget> _buildActionsAppbar() {
    if (_isSearch) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.myGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearch = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearch = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchEditingController.clear();
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildListCharactersWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildListCharactersWidget() {
    return SingleChildScrollView(
      primary: true,
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchEditingController.text.isEmpty
          ? allCharacters.length
          : _searchedForCharacters.length,
      itemBuilder: (ctx, index) => CharactersItem(
        character: _searchEditingController.text.isEmpty
            ? allCharacters[index]
            : _searchedForCharacters[index],
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: _isSearch
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        backgroundColor: MyColors.myYellow,
        actions: _buildActionsAppbar(),
        title: _isSearch ? _buildSearchFaild() : _buildAppBarTitle(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return _buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }

  Widget _buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              "Can't connect ... \nCheck your internet",
              style: TextStyle(
                color: MyColors.myYellow,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: Image.asset('assets/image/offline.png'),
            ),
          ],
        ),
      ),
    );
  }
}
