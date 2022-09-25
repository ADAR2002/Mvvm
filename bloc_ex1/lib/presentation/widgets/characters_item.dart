import 'package:bloc_ex1/constants/mycolors.dart';
import 'package:bloc_ex1/data/models/characters.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';

class CharactersItem extends StatelessWidget {
  final Character character;

  const CharactersItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
          color: MyColors.myWhite, borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context, charactersDetailsScreen,arguments: character),
        child: GridTile(
          child: Hero(

            tag: character.id,
            child: Container(
              color: MyColors.myGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/image/loading.gif',
                      image: character.image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/image/placeholder.jpg'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child:  Text(
              character.name,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
