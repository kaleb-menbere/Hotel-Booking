import 'package:flutter/material.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Hotels', 'Restaurants', '5 Star', '4 Star', '3 Star & Below'];

  final List<Map<String, dynamic>> _reviews = [
    {
      'id': '1',
      'place': 'Sheraton Addis',
      'type': 'Hotel',
      'date': 'Jan 20, 2024',
      'rating': 5,
      'comment': 'Excellent service and luxurious rooms! The staff was very helpful.',
      'likes': 12,
      'reply': 'Thank you for your kind words! We look forward to hosting you again.',
    },
    {
      'id': '2',
      'place': 'Kategna Restaurant',
      'type': 'Restaurant',
      'date': 'Dec 15, 2023',
      'rating': 4,
      'comment': 'Great traditional food, but the service was a bit slow during peak hours.',
      'likes': 8,
      'reply': '',
    },
    {
      'id': '3',
      'place': 'Hilton Addis Ababa',
      'type': 'Hotel',
      'date': 'Nov 10, 2023',
      'rating': 5,
      'comment': 'Perfect for business trips. Conference facilities are top-notch.',
      'likes': 15,
      'reply': 'Thank you for choosing us for your business needs!',
    },
    {
      'id': '4',
      'place': 'Yod Abyssinia',
      'type': 'Restaurant',
      'date': 'Oct 5, 2023',
      'rating': 3,
      'comment': 'Good cultural experience but food could be better.',
      'likes': 5,
      'reply': 'We appreciate your feedback and will work on improving our food quality.',
    },
    {
      'id': '5',
      'place': 'Bole Pension',
      'type': 'Pension',
      'date': 'Sep 20, 2023',
      'rating': 4,
      'comment': 'Great value for money. Clean rooms and friendly staff.',
      'likes': 7,
      'reply': '',
    },
  ];

  List<Map<String, dynamic>> get _filteredReviews {
    if (_selectedFilter == 'All') return _reviews;
    
    switch (_selectedFilter) {
      case 'Hotels':
        return _reviews.where((review) => review['type'] == 'Hotel').toList();
      case 'Restaurants':
        return _reviews.where((review) => review['type'] == 'Restaurant').toList();
      case '5 Star':
        return _reviews.where((review) => review['rating'] == 5).toList();
      case '4 Star':
        return _reviews.where((review) => review['rating'] == 4).toList();
      case '3 Star & Below':
        return _reviews.where((review) => review['rating'] <= 3).toList();
      default:
        return _reviews;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reviews'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _sortReviews,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filters
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) => setState(() => _selectedFilter = filter),
                    selectedColor: const Color(0xFF0A1F3A),
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  ),
                );
              },
            ),
          ),
          
          // Reviews List
          Expanded(
            child: _filteredReviews.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _filteredReviews.length,
                    itemBuilder: (context, index) {
                      return _buildReviewCard(_filteredReviews[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _writeNewReview,
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  review['type'] == 'Hotel' ? Icons.hotel : Icons.restaurant,
                  color: const Color(0xFF0A1F3A),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['place'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        review['date'],
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                _buildStars(review['rating']),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              review['comment'],
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            
            // Reply from business (if exists)
            if (review['reply']!.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Response from business:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Text(review['reply']!),
                  ],
                ),
              ),
            
            const SizedBox(height: 15),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    color: review['likes']! > 0 ? Colors.blue : Colors.grey,
                    size: 20,
                  ),
                  onPressed: () => _likeReview(review['id']),
                ),
                Text('${review['likes']}'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _editReview(review['id']),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                  onPressed: () => _deleteReview(review['id']),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.reviews, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          const Text(
            'No reviews yet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          const Text(
            'Share your experiences to help others',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _writeNewReview,
            icon: const Icon(Icons.edit),
            label: const Text('Write Your First Review'),
          ),
        ],
      ),
    );
  }

  void _likeReview(String id) {
    setState(() {
      final review = _reviews.firstWhere((r) => r['id'] == id);
      review['likes'] = review['likes'] + 1;
    });
  }

  void _editReview(String id) {
    final review = _reviews.firstWhere((r) => r['id'] == id);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Editing review for ${review['place']}'),
            const SizedBox(height: 20),
            TextField(
              controller: TextEditingController(text: review['comment']),
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Your Review',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Rating: '),
                _buildEditableStars(review['rating'], (newRating) {
                  review['rating'] = newRating;
                }),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Review updated')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableStars(int currentRating, Function(int) onRatingChanged) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < currentRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () => onRatingChanged(index + 1),
        );
      }),
    );
  }

  void _deleteReview(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Review'),
        content: const Text('Are you sure you want to delete this review?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _reviews.removeWhere((review) => review['id'] == id);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Review deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _sortReviews() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Sort Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildSortOption('Newest First', Icons.access_time),
            _buildSortOption('Oldest First', Icons.history),
            _buildSortOption('Highest Rated', Icons.star),
            _buildSortOption('Lowest Rated', Icons.star_border),
            _buildSortOption('Most Liked', Icons.thumb_up),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String label, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF0A1F3A)),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sorted by $label')),
        );
      },
    );
  }

  void _writeNewReview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Write a Review'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Place Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(labelText: 'Type (Hotel/Restaurant)'),
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Your Review'),
              ),
              const SizedBox(height: 10),
              const Text('Rating:'),
              _buildEditableStars(3, (rating) {}),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Review submitted!')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}