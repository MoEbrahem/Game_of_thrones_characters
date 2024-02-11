import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:game_of_thrones_characters/business_logic/cubit/charecters_cubit.dart';
import 'package:game_of_thrones_characters/constants/MyColors.dart';
import 'package:game_of_thrones_characters/data/models/characterModel.dart';
import 'package:game_of_thrones_characters/presentation/widgets/CharacterItems.dart';
import 'package:lottie/lottie.dart';

class Character_Screen extends StatefulWidget {
  const Character_Screen({super.key});

  @override
  State<Character_Screen> createState() => _Character_ScreenState();
}

class _Character_ScreenState extends State<Character_Screen> {
  List<Character> allcharacters = [];
  late List<Character> searchedForCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Find a Character ...",
          hintStyle: TextStyle(fontSize: 18, color: MyColors.myGrey)),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedcharacter) {
        addSearchForItemsToSearchedList(searchedcharacter);
      },
    );
  }

  void addSearchForItemsToSearchedList(String searchedcharacter) {
    searchedForCharacters = allcharacters
        .where((character) =>
            character.firstname.toLowerCase().startsWith(searchedcharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: MyColors.myGrey,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: startSearch,
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            )),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();

    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharectersState>(
        builder: (context, state) {
      if (state is CharectersLoaded) {
        allcharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
        child: Container(
      color: MyColors.myGrey,
      child: Column(
        children: [
          buildCharactersList(),
        ],
      ),
    ));
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
        itemCount: searchTextController.text.isEmpty
            ? allcharacters.length
            : searchedForCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
            characters: searchTextController.text.isEmpty
                ? allcharacters[index]
                : searchedForCharacters[index],
          );
        });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget appBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.myWhite),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Lottie.asset("assets/images/offline.json"),
            const Text(
              "Can't Connect .... Check Your Connection !!",
              style: TextStyle(fontSize: 22, color: MyColors.myGrey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 168, 12, 12),
          leading: isSearching
              ? const BackButton(color: MyColors.myGrey)
              : Container(),
          actions: buildAppBarActions(),
          title: isSearching ? buildSearchField() : appBarTitle(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              if (allcharacters.isEmpty) {
                return buildBlocWidget();
              } else {
                return buildLoadedListWidget();
              }
            } else {
              return buildNoInternetWidget();
            }
          },
          child: showLoadingIndicator(),
        ));
  }
}
