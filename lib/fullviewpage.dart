import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class fullview extends StatefulWidget {

  String mm; //name
  String mm1; //des
  String mm2; //image
  String mm3; // price

  fullview(this.mm, this.mm1, this.mm2, this.mm3);

  @override
  State<fullview> createState() => _fullviewState();
}

class _fullviewState extends State<fullview> {
  bool isFavorite = false;
  final _controller = PageController();
  Razorpay? _razorpay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: Text("${widget.mm}"),
        actions: [
          IconButton(
              splashRadius: 18.0,
              onPressed: () {},
              icon: isFavorite
                  ? Icon(
                Icons.bookmark,
                color: Colors.black,
              )
                  : Icon(
                Icons.bookmark_border_outlined,
                color: Colors.black,
              ))
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price',
                    style: TextStyle(
                        color: Colors.black45, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "₹${widget.mm3}",
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4),
                  ],
                )
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                _razorpay!.open(options);
              },
              child: Text("Buy Now"),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
              EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
              height: 420,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    onPageChanged: (value) {},
                    controller: _controller,
                    itemCount: 3,
                    itemBuilder: (contaxt, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Hero(
                            tag: index,
                            child: Image.network("https://darshanrabadiya.000webhostapp.com/${widget.mm2}",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                      bottom: 20,
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: 3,
                        effect: SwapEffect(
                            activeDotColor: Colors.white,
                            dotColor: Colors.white38,
                            spacing: 10),
                      )),
                ],
                // ).fadeAnimation(0.2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Synopsis",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text("${widget.mm1}"),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Color : ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.circle,
                        size: 40,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.circle,
                        size: 40,
                        color: Colors.greenAccent,
                      ),
                      Spacer(),
                      Icon(
                        Icons.indeterminate_check_box,
                        size: 40,
                        color: Colors.pink,
                      ),
                      Text(
                        " 1 ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.add_box,
                        size: 40,
                        color: Colors.pink,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: " Payment Successfully");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Payment Successfully");
  }

  Map<String, dynamic> options = {
    'key': 'rzp_test_U0E5SXISk6pySm',
    'amount': 10000,
    'name': 'Acme Corp.',
    'description': 'Fine T-Shirt',
    'prefill': {
      'contact': '9313392202',
      'email': 'darshanrabadiya8@gmail.com'
    }
  };
}
