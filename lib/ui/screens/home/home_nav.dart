import 'package:cart/data/repositories/cart_repository.dart';
import 'package:cart/ui/common_widgets/logout_popup_widget.dart';
import 'package:cart/ui/screens/cart/cart.dart';
import 'package:cart/ui/screens/cart/cart_cubit.dart';
import 'package:cart/ui/screens/home/home.dart';
import 'package:cart/ui/screens/home/home_cubit.dart';
import 'package:cart/ui/screens/profile/profile.dart';
import 'package:cart/ui/screens/profile/profile_cubit.dart';
import 'package:cart/ui/screens/wishlist/wishlist.dart';
import 'package:cart/ui/screens/wishlist/wishlist_cubit.dart';
import 'package:cart/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeNavigation extends StatefulWidget {
  final int? selectedIndex;
  const HomeNavigation({super.key, this.selectedIndex});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.selectedIndex != null ? widget.selectedIndex ?? 0 : 0;
  }

  Widget navigationPages(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return BlocProvider(
          create: (context) => HomeCubit(CartRepository())..getProductList(),
          child: HomeScreen(),
        );
        break;
      case 1:
        return BlocProvider(
          create: (context) =>
              WishlistCubit(CartRepository())..getProductList(),
          child: WishListScreen(),
        );
        break;
      case 2:
        return BlocProvider(
          create: (context) => CartCubit(CartRepository())..getcart(),
          child: CartScreen(),
        );
        break;
      case 3:
        return BlocProvider(
          create: (context) => ProfileCubit(CartRepository())..getprofile(),
          child: ProfileScreen(),
        );
        break;

      default:
        return Center(child: Text("404"));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Wish List',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Cart',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];

    return Scaffold(
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          scrolledUnderElevation: 0,
          toolbarHeight: 80,
          title: Text(
            "Aventus Cart",
            style: TextStyle(
                color: Appcolors.primarycolor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return LogoutPopUp();
                    },
                  );
                },
                child: Icon(Icons.logout)),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: navigationPages(_selectedIndex),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Appcolors.bottomNavColor,
          ),
          child: BottomNavigationBar(
            backgroundColor: Appcolors.bottomNavColor,
            currentIndex: _selectedIndex, // Set the active index
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: bottomNavItems,

            selectedItemColor: Appcolors.activebottomNavColor,
            unselectedItemColor: Appcolors.inActivebottomNavColor,
          ),
        ));
  }
}
