import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:game_of_thrones_characters/constants/MyColors.dart';

import 'package:game_of_thrones_characters/data/models/characterModel.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  // List allquotes = [];
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.fullname,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.imageURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: MyColors.myGrey,
      //centerTitle: true,
      pinned: true,
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
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

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      color: MyColors.myYellow,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  // Widget checkIfQuoteLoaded(state) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          buildSliverAppBar(),
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
                      character.fullname.isEmpty
                          ? Container()
                          : characterInfo("FullName : ", character.fullname),
                      character.fullname.isEmpty
                          ? Container()
                          : buildDivider(275),
                      character.family.isEmpty
                          ? Container()
                          : characterInfo("Family : ", character.family),
                      character.family.isEmpty
                          ? Container()
                          : buildDivider(295),
                      character.title.isEmpty
                          ? Container()
                          : characterInfo("Title : ", character.title),
                      character.title.isEmpty ? Container() : buildDivider(310),
                      const SizedBox(
                        height: 25,
                      ),
                      DefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: MyColors.myYellow,
                          fontSize: 20.0,
                          fontFamily: 'Bobbers',
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                                '${character.fullname} is a ${character.title} from ${character.family}'
                                ),
                          ],
                        ),
                      )
                      // BlocBuilder<QuotesCubit, QuotesState>(
                      //     builder: (context, state) {
                      //   return checkIfQuoteLoaded(state);
                      // })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 350,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
