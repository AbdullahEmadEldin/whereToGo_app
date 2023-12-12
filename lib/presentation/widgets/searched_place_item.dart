import 'package:flutter/material.dart';
import 'package:maps_app/data/models/place_suggestion.dart';
import 'package:maps_app/theme/app_theme.dart';

class SearchedPlaceItem extends StatelessWidget {
  final PlaceSuggestion placeSuggestion;
  const SearchedPlaceItem({
    super.key,
    required this.placeSuggestion,
  });

  @override
  Widget build(BuildContext context) {
    var subTitle = placeSuggestion.description
        .replaceAll(placeSuggestion.description.split(',')[0], '');
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.white),
      padding: const EdgeInsets.all(6),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color.fromARGB(77, 148, 145, 145)),
          child: Icon(
            Icons.place,
            color: kLightColorScheme.primary,
          ),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${placeSuggestion.description.split(',')[0]}\n',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black),
              ),
              TextSpan(
                text: subTitle.substring(2),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black38),
              )
            ],
          ),
        ),
      ),
    );
  }
}
