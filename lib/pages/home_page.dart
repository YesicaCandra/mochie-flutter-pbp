import 'package:flutter/material.dart';

import '../app_data.dart';
import '../models/mochi.dart';
import '../theme/app_theme.dart';
import 'cart_page.dart';
import 'favorite_page.dart';
import 'mochi_detail_page.dart';
import 'about_page.dart';

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

    // ==========================================
    // SEARCH
    // ==========================================

    if (_searchQuery.isNotEmpty) {
      result = result.where((mochi) {
        final name = mochi.name.toLowerCase();

        final description = mochi.description.toLowerCase();

        final query = _searchQuery.toLowerCase();

        return name.contains(query) || description.contains(query);
      }).toList();
    }

    // ==========================================
    // PILIHAN RASA
    // ==========================================

    if (_selectedFilter != 'Semua') {
      result = result.where((mochi) {
        final name = mochi.name.toLowerCase();

        return name.contains(_selectedFilter.toLowerCase());
      }).toList();
    }

    // ==========================================
    // SORT / URUTKAN
    // ==========================================

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

  Widget _buildHomeContent() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // =====================================================
          // HEADER
          // =====================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hello, Mochi Lover! 👋',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.darkPlum,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'Temukan Mochi Favoritmu',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.darkPlum,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // CART BUTTON
                  ValueListenableBuilder<List<Map<String, dynamic>>>(
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
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.darkPlum.withValues(
                                    alpha: 0.06,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartPage(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.shopping_bag_outlined,
                                color: AppTheme.darkPlum,
                              ),
                            ),
                          ),

                          if (totalQuantity > 0)
                            Positioned(
                              right: -4,
                              top: -5,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                constraints: const BoxConstraints(
                                  minWidth: 21,
                                  minHeight: 21,
                                ),
                                decoration: const BoxDecoration(
                                  color: AppTheme.dustyRoseDark,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  totalQuantity > 9 ? '9+' : '$totalQuantity',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // =====================================================
          // SEARCH BAR
          // =====================================================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.darkPlum.withValues(alpha: 0.05),
                      blurRadius: 15,
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
                    color: AppTheme.darkPlum,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Cari mochi favoritmu...',
                    hintStyle: TextStyle(
                      color: AppTheme.darkPlum.withValues(alpha: 0.45),
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppTheme.dustyRoseDark,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();

                              setState(() {
                                _searchQuery = '';
                              });
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                              color: AppTheme.darkPlum,
                            ),
                          )
                        : null,
                    filled: true,
                    fillColor: AppTheme.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: AppTheme.dustyRoseDark,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // =====================================================
          // PROMO BANNER
          // =====================================================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                height: 145,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.darkPlum, AppTheme.dustyRoseDark],
                  ),
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.darkPlum.withValues(alpha: 0.15),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'MOCHIÉ SPECIAL',
                              style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ),

                          const SizedBox(height: 9),

                          const Text(
                            'Sweet moments,\none bite away ✨',
                            style: TextStyle(
                              color: AppTheme.white,
                              fontSize: 18,
                              height: 1.2,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: AppTheme.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.icecream_outlined,
                        size: 42,
                        color: AppTheme.dustyRoseDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // =====================================================
          // PILIHAN RASA + JUMLAH + FILTER
          // =====================================================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Row(
                children: [
                  const Text(
                    'Pilihan Rasa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.darkPlum,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '${_filters.length - 1} rasa',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.darkPlum.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =====================================================
          // HORIZONTAL PILIHAN RASA
          // =====================================================
          SliverToBoxAdapter(
            child: SizedBox(
              height: 46,
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
                        color: isSelected ? AppTheme.white : AppTheme.darkPlum,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                      backgroundColor: AppTheme.white,
                      selectedColor: AppTheme.darkPlum,
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.darkPlum
                            : AppTheme.softPink,
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
          ),

          // =====================================================
          // VARIAN MOCHI + SORT
          // =====================================================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 14),
              child: Row(
                children: [
                  const Text(
                    'Varian Mochi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.darkPlum,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppTheme.dustyRoseDark,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const Spacer(),

                  PopupMenuButton<String>(
                    initialValue: _selectedSort,
                    onSelected: (value) {
                      setState(() {
                        _selectedSort = value;
                      });
                    },
                    color: AppTheme.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'Default',
                          child: Row(
                            children: [
                              Icon(
                                Icons.grid_view_rounded,
                                size: 19,
                                color: AppTheme.darkPlum,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Default',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),

                        const PopupMenuItem<String>(
                          value: 'Rating tertinggi',
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 19,
                                color: AppTheme.dustyRoseDark,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Rating tertinggi',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),

                        const PopupMenuItem<String>(
                          value: 'Harga termahal',
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_upward_rounded,
                                size: 19,
                                color: AppTheme.darkPlum,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Harga termahal',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),

                        const PopupMenuItem<String>(
                          value: 'Harga termurah',
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_downward_rounded,
                                size: 19,
                                color: AppTheme.darkPlum,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Harga termurah',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedSort == 'Default'
                            ? AppTheme.white
                            : AppTheme.softPink,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: _selectedSort == 'Default'
                              ? AppTheme.softPink
                              : AppTheme.dustyRoseDark,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.tune_rounded,
                            size: 17,
                            color: AppTheme.darkPlum,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _sortLabel(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.darkPlum,
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 17,
                            color: AppTheme.darkPlum,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =====================================================
          // ACTIVE FILTER INDICATOR
          // =====================================================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                children: [
                  if (_selectedFilter != 'Semua')
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.softPink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_offer_outlined,
                            size: 14,
                            color: AppTheme.darkPlum,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _selectedFilter,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.darkPlum,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_selectedSort != 'Default') ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.softPink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _sortLabel(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.darkPlum,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // =====================================================
          // PRODUCT LIST
          // =====================================================
          if (_filteredMochi.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    const Icon(
                      Icons.search_off_rounded,
                      size: 58,
                      color: AppTheme.dustyRoseDark,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Mochi tidak ditemukan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkPlum,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Coba gunakan kata kunci atau filter lain.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.darkPlum.withValues(alpha: 0.65),
                      ),
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
                      child: const Text(
                        'RESET PENCARIAN',
                        style: TextStyle(
                          color: AppTheme.darkPlum,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final mochi = _filteredMochi[index];

                  return AnimatedMochiCard(
                    index: index,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildPolishedCard(context, mochi),
                    ),
                  );
                }, childCount: _filteredMochi.length),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPolishedCard(BuildContext context, Mochi mochi) {
    final rating = mochi.rating;

    final isFavorite = AppData.isFavorite(mochi.name);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkPlum.withValues(alpha: 0.06),
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
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MochiDetailPage(mochi: mochi),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, 0.08);
                      const end = Offset.zero;

                      final slideAnimation =
                          Tween<Offset>(begin: begin, end: end).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            ),
                          );

                      final fadeAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      );

                      return FadeTransition(
                        opacity: fadeAnimation,
                        child: SlideTransition(
                          position: slideAnimation,
                          child: child,
                        ),
                      );
                    },
                transitionDuration: const Duration(milliseconds: 400),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // IMAGE
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        mochi.image,
                        width: 125,
                        height: 145,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      top: 12,
                      right: 12,
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

                const SizedBox(width: 15),

                // CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mochi.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.darkPlum,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        mochi.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: AppTheme.darkPlum.withValues(alpha: 0.65),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.softPink,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 15,
                                  color: AppTheme.dustyRoseDark,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.darkPlum,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          Text(
                            mochi.price,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.darkPlum,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 38,
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
                                  foregroundColor: AppTheme.darkPlum,
                                  elevation: 0,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'DETAIL',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: SizedBox(
                              height: 38,
                              child: AnimatedCartButton(
                                onPressed: () {
                                  AppData.addToCart(mochi.toMap());

                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${mochi.name} ditambahkan ke cart',
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: AppTheme.darkPlum,
                                      margin: const EdgeInsets.all(16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.darkPlum,
                                  foregroundColor: AppTheme.white,
                                  elevation: 0,
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

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeContent(),
      const FavoritePage(),
      const AboutPage(),
    ];

    return Scaffold(
      backgroundColor: AppTheme.cream,
      body: pages[_selectedIndex],

      bottomNavigationBar: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: AppData.favorites,
        builder: (context, favorites, child) {
          return NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onNavigationTap,
            backgroundColor: AppTheme.white,
            indicatorColor: AppTheme.dustyRose,
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
                label: 'About',
              ),
            ],
          );
        },
      ),
    );
  }
}

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
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.92),
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
            color: widget.isFavorite
                ? AppTheme.dustyRoseDark
                : AppTheme.darkPlum,
            size: 20,
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
