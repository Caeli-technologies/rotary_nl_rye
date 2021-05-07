import 'package:flutter/widgets.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class HomeCardsItem extends StatelessWidget {
  final String picturePath, title, description;

  HomeCardsItem({
    required this.picturePath,
    required this.title,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.only(left: 16),
        height: 120,
        decoration: BoxDecoration(
          color: Palette.themeShadeColor,
          borderRadius: BorderRadius.circular(12),
          border:
          Border.all(color: Palette.grey, width: 1),
        ),
        child: Row(
          children: <Widget>[
            Container(
                width: 50,
                height: 50,
                // fills the missing space in the circle
                //
                //decoration: BoxDecoration(
                //  borderRadius: BorderRadius.circular(40),
                //  color: Palette.imageBackgroundColor, //fill the image still needs to chagnge
                //),
                child: ClipRRect(
                  borderRadius:
                  new BorderRadius.circular(40.0),
                  child: Image.asset(picturePath),
               ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 12,
                        color: Palette.indigo),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 10,
                        color: Palette.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}