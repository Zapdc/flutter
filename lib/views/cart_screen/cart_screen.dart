import 'package:goan_market/consts/consts.dart';

class CartScreen extends StatelessWidget{
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
        color: Colors.white,
        child: "Cart is Empty!".text.fontFamily(bold).color(darkFontGrey).makeCentered(),
    );
  }
}