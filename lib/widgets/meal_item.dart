import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../providers/language_provider.dart';
import '../screens/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  String imageUrl;
 final Complexity complexity;
 final Affordability affordability;
  int duration;
  String id ;
  MealItem({
    required this.id,
    required this.affordability,
    required this.complexity,
    required this.duration,
    required this.imageUrl,
  });

  void selectItem(ctx) {

    Navigator.of(ctx).pushNamed(
        MealDetailScreen.routeMealDetailScreen,
         arguments: id ,
    ) ;
  }
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return InkWell(
      onTap: () =>selectItem(context),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(tag: id,
                    child:InteractiveViewer(
                      child: FadeInImage(
                        placeholder: AssetImage('assets/images/a2.png'),
                        image: NetworkImage(
                          imageUrl,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                        lan.getTexts('meal-$id').toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: flipAxis(Axis.horizontal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.schedule,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          if(duration <= 10)Text("$duration ${lan.getTexts('min')}"),
                          Text("$duration ${lan.getTexts('min2')}",
                            style: const TextStyle(color:Colors.black) ,

                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.work,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(lan.getTexts('$complexity').toString(),
                           style: const TextStyle(color:Colors.black) ,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.attach_money,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                              lan.getTexts('$affordability',).toString(),
                            style: const TextStyle(color:Colors.black) ,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
