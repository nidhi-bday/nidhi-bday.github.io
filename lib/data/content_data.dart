import '../models/content_item.dart';

class ContentData {
  // Centralized source-of-truth. Replace paths/URLs as needed.
  static final ContentItem featured = ContentItem(
    id: 'nidhi_21st_birthday',
    title: 'Nidhi\'s 21st Birthday',
    description:
        'Happy Birthday to someone who fils every moment with joy, warmth, and unforgettable memories. Today isen\'t just about celebrating another year, its about honoring the light you bring into lives of everyone around you. May your day be filled with love, laughter and everything your heart desires. Here\'s to the beautifull journey behind you, and the even more incredible adventure ahead.\nYou are truely one of a kind. Wishing you the happiest birthday ever.',
    thumbnail: 'assets/nidhi/featured/preview_thumbnail.png',
    bannerImage: 'assets/nidhi/featured/preview_thumbnail.png',
    previewVideo: 'assets/nidhi/Nidhi_Bollywood_day.mp4',
    categories: ['Drama', 'Mystery'],
    topRank: '#Best Birthday Ever',
    autoplay: true,
    year: 2026,
    maturity: '16+',
    duration: '42m',
    starring: 'Nidhi Rajput',
    genre: 'Birthday, Drama queen, bubzi',
  );

  static final List<ContentItem> popular = List.generate(
    8,
    (i) => ContentItem(
      id: 'popular_$i',
      title: 'Popular Show ${i + 1}',
      description: 'Short description for Popular Show ${i + 1}',
      thumbnail: 'assets/nidhi/row1/${i + 1}.jpg',
      bannerImage: 'assets/nidhi/row1/${i + 1}.jpg',
      previewVideo: '',
      categories: ['Popular'],
      autoplay: false,
      year: 2021,
    ),
  );

  static final List<ContentItem> trending = List.generate(
    8,
    (i) => ContentItem(
      id: 'trending_$i',
      title: 'Trending ${i + 1}',
      description: 'Trending now description ${i + 1}',
      thumbnail: 'assets/nidhi/row2/${i + 1}.jpg',
      bannerImage: 'assets/nidhi/row2/${i + 1}.jpg',
      previewVideo: '',
      categories: ['Trending'],
      autoplay: false,
      year: 2022,
    ),
  );

  static final List<ContentItem> suggested = List.generate(
    8,
    (i) => ContentItem(
      id: 'suggested_$i',
      title: 'Suggested ${i + 1}',
      description: 'Suggested description ${i + 1}',
      thumbnail: 'assets/nidhi/row3/${i + 1}.jpg',
      bannerImage: 'assets/nidhi/row3/${i + 1}.jpg',
      previewVideo: '',
      categories: ['Suggested'],
      autoplay: false,
      year: 2023,
    ),
  );

  static Map<String, List<ContentItem>> rows = {'Popular on App': popular, 'Trending Now': trending, 'You Might Like': suggested};
}

// import '../models/content_item.dart';

// class ContentData {
//   // Centralized source-of-truth. Replace paths/URLs as needed.
//   static final ContentItem featured = ContentItem(
//     id: 'devil_in_ohio',
//     title: 'Devil in Ohio',
//     description: 'Determined to protect a young patient, a psychiatrist becomes entangled in a secretive cult.',
//     thumbnail: 'https://picsum.photos/200/300?image=1067',
//     bannerImage: 'https://picsum.photos/1200/600?image=1033',
//     previewVideo: 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
//     categories: ['Drama', 'Mystery'],
//     topRank: '#Best Birthday Ever',
//     autoplay: true,
//     year: 2026,
//     maturity: '16+',
//     duration: '42m',
//   );

//   static final List<ContentItem> popular = List.generate(
//     10,
//     (i) => ContentItem(
//       id: 'popular_$i',
//       title: 'Popular Show ${i + 1}',
//       description: 'Short description for Popular Show ${i + 1}',
//       thumbnail: 'https://picsum.photos/300/170?random=$i',
//       bannerImage: 'https://picsum.photos/1200/600?random=${i + 10}',
//       previewVideo: '',
//       categories: ['Popular'],
//       autoplay: false,
//       year: 2021,
//     ),
//   );

//   static final List<ContentItem> trending = List.generate(
//     8,
//     (i) => ContentItem(
//       id: 'trending_$i',
//       title: 'Trending ${i + 1}',
//       description: 'Trending now description ${i + 1}',
//       thumbnail: 'https://picsum.photos/300/170?random=${i + 20}',
//       bannerImage: 'https://picsum.photos/1200/600?random=${i + 30}',
//       previewVideo: '',
//       categories: ['Trending'],
//       autoplay: false,
//       year: 2022,
//     ),
//   );

//   static Map<String, List<ContentItem>> rows = {'Popular on App': popular, 'Trending Now': trending};
// }
