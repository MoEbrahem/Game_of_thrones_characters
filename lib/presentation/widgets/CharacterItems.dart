import 'package:flutter/material.dart';
import 'package:game_of_thrones_characters/constants/MyColors.dart';
import 'package:game_of_thrones_characters/constants/strings.dart';
import 'package:game_of_thrones_characters/data/models/characterModel.dart';
import 'package:lottie/lottie.dart';

class CharacterItem extends StatelessWidget {
  final Character characters;
  const CharacterItem({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(4),
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(charactersDetails, arguments: characters);
              
              
        },
        child: GridTile(
          footer: Hero(
            tag: characters.id,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              width: double.infinity,
              child: Text(
                characters.fullname,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  height: 1.5,
                  color: MyColors.myWhite,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            child: characters.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: 'assets/images/loading.gif',
                    image: characters.imageURL,
                  )
                : Lottie.asset("assets/images/Nodata.json"),
          ),
        ),
      ),
    );
  }
}
