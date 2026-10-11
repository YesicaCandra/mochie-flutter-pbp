import 'package:flutter/material.dart';

import '../app_data.dart';
import '../models/mochi.dart';
import '../theme/app_theme.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/mochi_image.dart';
import 'cart_page.dart';
import 'favorite_page.dart';
import 'mochi_detail_page.dart';
import 'profile_page.dart';

final List<Mochi> mochiData = [
  Mochi(
    name: 'Mochi Strawberry',
    description: 'Mochi lembut dengan isian strawberry yang manis dan segar.',
    detailDescription: 'Mochi Strawberry dibuat dengan kulit mochi yang lembut dan kenyal, dipadukan dengan isian strawberry yang manis dan segar. Cocok dinikmati sebagai camilan manis kapan saja.',
    price: 'Rp12.000',
    rating: 4.8,
    image: 'assets/images/mochi strawberry.jpeg',
  ),

  Mochi(
    name: 'Mochi Matcha',
    description: 'Mochi dengan rasa matcha yang lembut dan sedikit pahit.',
    detailDescription: 'Mochi Matcha memiliki tekstur lembut dengan perpaduan rasa matcha yang khas, creamy, dan sedikit pahit sehingga memberikan rasa yang seimbang.',
    price: 'Rp13.000',
    rating: 4.7,
    image: 'assets/images/mochi matcha.webp',
  ),

  Mochi(
    name: 'Mochi Chocolate',
    description: 'Mochi dengan isian cokelat creamy yang manis.',
    detailDescription: 'Mochi Chocolate menghadirkan perpaduan kulit mochi yang lembut dengan isian cokelat creamy yang manis dan cocok untuk pecinta cokelat.',
    price: 'Rp12.000',
    rating: 4.9,
    image: 'assets/images/mochi chocolate.jpg',
  ),

  Mochi(
    name: 'Mochi Taro',
    description: 'Mochi lembut dengan rasa taro yang creamy dan harum.',
    detailDescription: 'Mochi Taro memiliki rasa taro yang lembut, creamy, dan harum dengan tekstur mochi yang kenyal.',
    price: 'Rp13.000',
    rating: 4.8,
    image: 'assets/images/mochi taro.jpg',
  ),

  Mochi(
    name: 'Mochi Mango',
    description: 'Perpaduan mochi lembut dengan rasa mangga yang segar.',
    detailDescription: 'Mochi Mango memiliki rasa mangga yang manis dan segar dengan tekstur mochi yang lembut dan kenyal.',
    price: 'Rp12.000',
    rating: 4.7,
    image: 'assets/images/mochi mango.jpg',
  ),

  Mochi(
    name: 'Mochi Red Velvet',
    description: 'Mochi dengan cita rasa red velvet yang lembut dan creamy.',
    detailDescription: 'Mochi Red Velvet menawarkan rasa red velvet yang lembut dan creamy dengan tekstur mochi yang kenyal.',
    price: 'Rp14.000',
    rating: 4.9,
    image: 'assets/images/mochi red velvet.jpg',
  ),
];

// Gaya teks judul (Fredoka).
TextStyle _displayStyle(
  double size, {
  Color color = AppTheme.cocoa,
  double? height,
}) {
  return TextStyle(
    fontFamily: AppTheme.fontDisplay,
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: color,
    height: height,
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  String _searchQuery = '';
  String _selectedFilter = 'Semua';
  String _selectedSort = 'Default';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'Semua',
    'Strawberry',
    'Matcha',
    'Chocolate',
    'Taro',
    'Mango',
    'Red Velvet',
  ];

  double _getPrice(String price) {
    final number = price
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();

    return double.tryParse(number) ?? 0;
  }

  String _sortLabel() {
    switch (_selectedSort) {
      case 'Rating tertinggi':
        return 'Rating ↑';
      case 'Harga termahal':
        return 'Harga ↑';
      case 'Harga termurah':
        return 'Harga ↓';
      default:
        return 'Filter';
    }
  }

  List<Mochi> get _filteredMochi {
    List<Mochi> result = List<Mochi>.from(mochiData);

    // SEARCH
    if (_searchQuery.isNotEmpty) {
      result = result.where((mochi) {
        final name = mochi.name.toLowerCase();
        final description = mochi.description.toLowerCase();
        final query = _searchQuery.toLowerCase();

        return name.contains(query) || description.contains(query);
      }).toList();
    }

    // PILIHAN RASA
    if (_selectedFilter != 'Semua') {
      result = result.where((mochi) {
        final name = mochi.name.toLowerCase();

        return name.contains(_selectedFilter.toLowerCase());
      }).toList();
    }

    // SORT / URUTKAN
    if (_selectedSort == 'Rating tertinggi') {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    }

    if (_selectedSort == 'Harga termahal') {
      result.sort((a, b) => _getPrice(a.price).compareTo(_getPrice(b.price)));

      result = result.reversed.toList();
    }

    if (_selectedSort == 'Harga termurah') {
      result.sort((a, b) => _getPrice(a.price).compareTo(_getPrice(b.price)));
    }

    return result;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onNavigationTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ===========================================================
  // HEADER (sapaan + tombol keranjang)
  // ===========================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Mochi Lover!',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.cocoa.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Temukan Mochi Favoritmu',
                      style: _displayStyle(24, height: 1.15),
                    ),
                  ],
                ),
              ),
            ),
          ),

          _buildCartButton(),
        ],
      ),
    );
  }

  Widget _buildCartButton() {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: AppData.cart,
      builder: (context, cart, child) {
        final totalQuantity = cart.fold<int>(
          0,
          (sum, item) => sum + ((item['quantity'] ?? 1) as int),
        );

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.cocoa.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                tooltip: 'Keranjang',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppTheme.cocoa,
                ),
              ),
            ),

            if (totalQuantity > 0)
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryDeep,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    totalQuantity > 9 ? '9+' : '$totalQuantity',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // ===========================================================
  // SEARCH BAR
  // ===========================================================

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppTheme.cocoa.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          style: const TextStyle(
            color: AppTheme.cocoa,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            hintText: 'Cari mochi favoritmu...',
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppTheme.primaryDeep,
              size: 22,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    tooltip: 'Hapus pencarian',
                    onPressed: () {
                      _searchController.clear();

                      setState(() {
                        _searchQuery = '';
                      });
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppTheme.cocoa,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // BANNER PROMO
  // ===========================================================

  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 128),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.primaryDeep, AppTheme.primary],
          ),
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.25),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'MOCHIÉ SPECIAL',
                      style: TextStyle(
                        color: AppTheme.cocoa,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Sweet moments,\none bite away',
                    style: _displayStyle(
                      22,
                      color: AppTheme.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Dua bola mochi dekoratif
            SizedBox(
              width: 108,
              height: 72,
              child: Stack(
                children: const [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: _MochiBall(size: 70, color: AppTheme.peach),
                  ),
                  Positioned(
                    left: 52,
                    bottom: 0,
                    child: _MochiBall(size: 56, color: AppTheme.yellow),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // CHIP PILIHAN RASA
  // ===========================================================

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 42,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: _filters.length,
          itemBuilder: (context, index) {
            final filter = _filters[index];
            final isSelected = _selectedFilter == filter;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                labelStyle: TextStyle(
                  color: isSelected ? AppTheme.white : AppTheme.cocoa,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                backgroundColor: AppTheme.white,
                selectedColor: AppTheme.primaryDeep,
                side: BorderSide(
                  color: isSelected ? AppTheme.primaryDeep : AppTheme.dustyRose,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                showCheckmark: false,
              ),
            );
          },
        ),
      ),
    );
  }

  // ===========================================================
  // JUDUL "VARIAN MOCHI" + FILTER/SORT
  // ===========================================================

  PopupMenuItem<String> _sortItem(String value, IconData icon, Color color) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 19, color: color),
          const SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    final isSortActive = _selectedSort != 'Default';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
      child: Row(
        children: [
          Text('Varian Mochi', style: _displayStyle(20)),

          const Spacer(),

          PopupMenuButton<String>(
            initialValue: _selectedSort,
            onSelected: (value) {
              setState(() {
                _selectedSort = value;
              });
            },
            itemBuilder: (context) {
              return [
                _sortItem('Default', Icons.grid_view_rounded, AppTheme.cocoa),
                _sortItem(
                  'Rating tertinggi',
                  Icons.star_rounded,
                  AppTheme.primaryDeep,
                ),
                _sortItem(
                  'Harga termahal',
                  Icons.arrow_upward_rounded,
                  AppTheme.cocoa,
                ),
                _sortItem(
                  'Harga termurah',
                  Icons.arrow_downward_rounded,
                  AppTheme.cocoa,
                ),
              ];
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: isSortActive ? AppTheme.softPink : AppTheme.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: isSortActive ? AppTheme.primary : AppTheme.dustyRose,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _sortLabel(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.cocoa,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppTheme.cocoa,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // KONTEN HOME
  // ===========================================================

  Widget _buildHomeContent() {
    // Dihitung sekali per build.
    final mochiList = _filteredMochi;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildSearchBar()),
          SliverToBoxAdapter(child: _buildPromoBanner()),
          SliverToBoxAdapter(child: _buildFilterChips()),
          SliverToBoxAdapter(child: _buildSectionHeader()),

          if (mochiList.isEmpty)
            SliverToBoxAdapter(child: _buildEmptyResult())
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final mochi = mochiList[index];

                  return AnimatedMochiCard(
                    index: index,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildPolishedCard(context, mochi),
                    ),
                  );
                }, childCount: mochiList.length),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyResult() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: AppTheme.softPink,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 44,
              color: AppTheme.primary,
            ),
          ),

          const SizedBox(height: 16),

          Text('Mochi tidak ditemukan', style: _displayStyle(20)),

          const SizedBox(height: 6),

          Text(
            'Coba gunakan kata kunci atau filter lain.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.cocoa.withValues(alpha: 0.75)),
          ),

          const SizedBox(height: 18),

          TextButton(
            onPressed: () {
              _searchController.clear();

              setState(() {
                _searchQuery = '';
                _selectedFilter = 'Semua';
                _selectedSort = 'Default';
              });
            },
            child: const Text('RESET PENCARIAN'),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // KARTU PRODUK
  // ===========================================================

  void _openDetail(BuildContext context, Mochi mochi) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            MochiDetailPage(mochi: mochi),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.08);
          const end = Offset.zero;

          final slideAnimation = Tween<Offset>(begin: begin, end: end).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          );

          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(position: slideAnimation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  Widget _buildPolishedCard(BuildContext context, Mochi mochi) {
    final isFavorite = AppData.isFavorite(mochi.name);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            _openDetail(context, mochi);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                // GAMBAR + FAVORIT
                Stack(
                  children: [
                    MochiImage(
                      path: mochi.image,
                      width: 104,
                      height: 128,
                      borderRadius: 18,
                    ),

                    Positioned(
                      top: 6,
                      right: 6,
                      child: AnimatedFavoriteButton(
                        isFavorite: isFavorite,
                        onPressed: () {
                          AppData.toggleFavorite(mochi.toMap());
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                // KONTEN
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mochi.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _displayStyle(16),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        mochi.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: AppTheme.cocoa.withValues(alpha: 0.8),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.yellow,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 13,
                                  color: AppTheme.cocoa,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  mochi.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.cocoa,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          Text(
                            mochi.price,
                            style: _displayStyle(
                              16,
                              color: AppTheme.primaryDeep,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MochiDetailPage(mochi: mochi),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.softPink,
                                  foregroundColor: AppTheme.cocoa,
                                  elevation: 0,
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'DETAIL',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          SizedBox(
                            width: 52,
                            height: 36,
                            child: AnimatedCartButton(
                              onPressed: () {
                                AppData.addToCart(mochi.toMap());

                                AppSnackBar.success(
                                  context,
                                  '${mochi.name} ditambahkan ke cart',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                foregroundColor: AppTheme.white,
                                elevation: 0,
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Icon(
                                Icons.shopping_bag_outlined,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // BUILD
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeContent(),
      FavoritePage(onExplore: () => _onNavigationTap(0)),
      ProfilePage(onSelectTab: _onNavigationTap),
    ];

    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: pages[_selectedIndex],

      bottomNavigationBar: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: AppData.favorites,
        builder: (context, favorites, child) {
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.cocoa.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onNavigationTap,
                backgroundColor: Colors.transparent,
                elevation: 0,
                destinations: [
                  const NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),

                  NavigationDestination(
                    icon: Badge(
                      isLabelVisible: favorites.isNotEmpty,
                      label: Text(favorites.length.toString()),
                      child: const Icon(Icons.favorite_border_rounded),
                    ),
                    selectedIcon: Badge(
                      isLabelVisible: favorites.isNotEmpty,
                      label: Text(favorites.length.toString()),
                      child: const Icon(Icons.favorite_rounded),
                    ),
                    label: 'Favorite',
                  ),

                  const NavigationDestination(
                    icon: Icon(Icons.person_outline_rounded),
                    selectedIcon: Icon(Icons.person_rounded),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// =============================================================
// BOLA MOCHI DEKORATIF (untuk banner)
// =============================================================

class _MochiBall extends StatelessWidget {
  final double size;
  final Color color;

  const _MochiBall({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.3, -0.4),
          radius: 0.9,
          colors: [AppTheme.white, color],
          stops: const [0.0, 0.72],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cocoa.withValues(alpha: 0.15),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// ANIMASI KARTU, FAVORIT, DAN TOMBOL CART
// =============================================================

class AnimatedMochiCard extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedMochiCard({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<AnimatedMochiCard> createState() => _AnimatedMochiCardState();
}

class _AnimatedMochiCardState extends State<AnimatedMochiCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350 + (widget.index * 70)),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.index * 70), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

class AnimatedFavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const AnimatedFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  State<AnimatedFavoriteButton> createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton> {
  double _scale = 1.0;

  Future<void> _handleTap() async {
    setState(() {
      _scale = 1.25;
    });

    widget.onPressed();

    await Future.delayed(const Duration(milliseconds: 120));

    if (mounted) {
      setState(() {
        _scale = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutBack,
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            widget.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: AppTheme.primaryDeep,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class AnimatedCartButton extends StatefulWidget {
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget child;

  const AnimatedCartButton({
    super.key,
    required this.onPressed,
    this.style,
    required this.child,
  });

  @override
  State<AnimatedCartButton> createState() => _AnimatedCartButtonState();
}

class _AnimatedCartButtonState extends State<AnimatedCartButton> {
  double _scale = 1.0;

  Future<void> _handlePressed() async {
    setState(() {
      _scale = 0.96;
    });

    widget.onPressed();

    await Future.delayed(const Duration(milliseconds: 100));

    if (mounted) {
      setState(() {
        _scale = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: ElevatedButton(
        onPressed: _handlePressed,
        style: widget.style,
        child: widget.child,
      ),
    );
  }
}
