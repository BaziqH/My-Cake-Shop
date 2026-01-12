import 'package:cake_shop_ui/Cakes_Data.dart';
import 'package:cake_shop_ui/Customised_Order.dart';
import 'package:cake_shop_ui/bottom_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[50],
//       body: Padding(
//           padding: EdgeInsets.only(left: 25, right: 25, top: 100, bottom: 10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Cart(),
//                   Spacer(),
//                   Avatar(),
//                 ],
//               ),
//               Spacer(),
//               TextHeader(headerText: "Cakes",),
//               Spacer(),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: cakes.map((e) => ProductCard(cake: e)).toList(),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextHeader(headerText: 'Offers',),
//               CustomizedCard(cake: cakes[0]),
//
//
//             ],
//           )
//       ),
//       bottomNavigationBar: BottomTabBar(),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Cart(),
                  Spacer(),
                  Avatar(),
                ],
              ),
            ),

            // Scrollable content from "Cakes" onward
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0),
                    TextHeader(headerText: "Cakes"),
                    const SizedBox(height: 10),

                    SizedBox(
                      height: 280, // give enough height for your ProductCard + spacing
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: cakes.map((e) => Padding(
                            padding: const EdgeInsets.only(right: 16), // spacing between cards
                            child: ProductCard(cake: e),
                          )).toList(),
                        ),
                      ),
                    ),
                    
                    TextHeader(headerText: "Custom Cakes"),

                    SizedBox(
                      height: 300,
                      // enough for your cards and spacing
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: SizedBox(
                                width: 330,
                                child: CustomizedCard(cake: cakes[0]),
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SizedBox(
                                width: 330,
                                child: CustomizedCard(cake: cakes[0]),
                              )
                            ),
                            // Add more cards similarly
                          ],
                        ),
                      ),
                    ),



                    // const SizedBox(height: 10),
                    // CustomizedCard(cake: cakes[0]),
                    // const SizedBox(height: 70),
                    // CustomizedCard(cake: cakes[0]),
                    // const SizedBox(height: 20),
                    CustomizedOrderCard(),

                    const SizedBox(height: 10), // Final spacing at bottom
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomTabBar(),
    );
  }
}




class TextHeader extends StatelessWidget {
  String headerText;

  TextHeader({
    super.key,
    required this.headerText
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          headerText,
          style: TextStyle(
              color: Colors.black,
              fontSize: 34,
              fontWeight: FontWeight.w500),
        ),
        Spacer(),
        Text(
          "See more",
          style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class Cart extends StatelessWidget {
  const Cart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [ Container(
        height: 100,
        width: 85,
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(15)),
        child: const Column(
          children: [
            SizedBox(
              height: 18,
            ),
            Text(
              "6",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Pending \n Orders",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            )
          ],
      ),
      ),
        Positioned(
          top: -20,
          left: 20.125,
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.orangeAccent),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
          ),
        ),],
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.orangeAccent,
          child: Icon(Icons.person),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "Finalize\n Orders",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14),
        )
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Cake cake;
  const ProductCard({super.key, required this.cake});

  @override
  Widget build(BuildContext context){

    var size = MediaQuery.of(context).size;
    var cakeImageSize = size.height * 0.16;
    var cardSize = size.height * 0.20;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: cardSize,
          width: cardSize,
          decoration: BoxDecoration(
            color: Colors.black54,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(6, 5),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(55),
              bottomRight: Radius.circular(130),
            )
          ),
          child: Padding(

              padding: EdgeInsets.only(left: 16, top: 32, right: 32, bottom: 16),
              child: Column (

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    cake.name,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                        size: 10,
                      ),
                      SizedBox(
                        width: 2,
                        height: 2,
                      ),
                      Text(
                        "Best Seller",
                        style:
                        TextStyle(color: Colors.orangeAccent, fontSize: 18),
                      ),
                    ]
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    cake.price.toString() + " \-",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                    ),
                  )
                ],

              ),

          ),
        ),
        Positioned(
          top: -(cakeImageSize - 80),
          left: (cardSize - cakeImageSize) / 2,
          child: SizedBox(
            height: cakeImageSize,
            width: cakeImageSize,
            child: Image.asset(cake.image),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white, shape: BoxShape.circle
            ),
            child: Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.black,
            ),
          ),

        ),

      ],


    );
  }
}

class CustomizedCard extends StatelessWidget {
  final Cake cake;
  const CustomizedCard({super.key, required this.cake});

  @override
  Widget build(BuildContext context){

    var size = MediaQuery.of(context).size;
    var cakeImageSize = size.height * 0.16;
    var cardSize = size.height * 0.20;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: cardSize,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black54,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  offset: Offset(6, 5),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(55),
                bottomRight: Radius.circular(130),
              )
          ),
          child: Padding(

            padding: EdgeInsets.only(left: 16, top: 16, right: 0, bottom: 16),
            child: Column (

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  cake.name,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                        size: 10,
                      ),
                      SizedBox(
                        width: 2,
                        height: 2,
                      ),
                      Text(
                        "Best Seller",
                        style:
                        TextStyle(color: Colors.orangeAccent, fontSize: 18),
                      ),

                    ]

                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  cake.price.toString() + " /-",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28
                  ),
                )
              ],

            ),

          ),
        ),
        Positioned(
          top: -(cakeImageSize - 80),
          left: (cardSize - cakeImageSize) / 2,
          child: SizedBox(
            height: cakeImageSize -20,
            width: size.width - 50,
            child: Image.asset(cake.image),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle
            ),
            child: Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.black,
            ),
          ),

        ),

      ],


    );
  }


}

class CustomizedOrderCard extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    var size = MediaQuery.of(context).size;
    var cardSize = size.height * 0.10;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(

          height: cardSize,
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.black54,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  offset: Offset(6, 5),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(55),
                bottomRight: Radius.circular(130),
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 16),
            child: Column (

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),

                Row(

                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                        size: 10,

                      ),
                      SizedBox(
                        width: 2,
                        height: 2,
                      ),
                      Text(
                        "Order Custom Cake",
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ]
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),

        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle
            ),
            child: Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}