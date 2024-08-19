import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/const/snackbars.dart';
import 'package:e_mart_seller/controller/auth_controller.dart';
import 'package:e_mart_seller/views/home_screen/home.dart';
import 'package:get/get.dart';

class loginScreen extends StatelessWidget {
  loginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: purpleColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Hi, Welcome to', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white30, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  child: Image.asset(
                    'assets/icons/logo.png',
                    scale: 3,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'eMart Seller App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * .3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email, color: purpleColor),
                          hintText: 'eg vender@emart.com'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.lock, color: purpleColor),
                          hintText: '********'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forget Password?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Obx(() {
                    return InkWell(
                      onTap: () async {
                        controller.isLoading(true);

                        await controller
                            .signInMethod(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          if (value != null) {
                            Get.snackbar("Successfully", "Login Sucesfully",
                                backgroundColor: green);
                            controller.isLoading(false);
                            Get.offAll(() => const Home());
                          } else {
                            controller.isLoading(false);
                            errorSnack("Fill the fields");
                          }
                        });
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * .8,
                        decoration: BoxDecoration(
                            color: purpleColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(color: white)
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            // Text('data')
          ],
        ),
      )),
    );
  }
}
