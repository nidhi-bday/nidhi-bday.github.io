import 'package:birthday_website/models/birthday_message.dart';

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

final List<BirthdayMessage> messages = [
  BirthdayMessage(
    image: "assets/nidhi/messages/vidhi.jpeg",
    name: "Vidhi",
    message:
        "You’re younger than me, but somehow you protected me like an elder sister. You held my heart together on days I was falling apart.You became my every mood, every safe place, every tiny piece of happiness. I just pray I become successful enough to give my little queen the whole world one day.",
  ),
  BirthdayMessage(
    image: "assets/nidhi/messages/sidd.jpeg",
    name: "Siddhant",
    // relation: "Best Friend ❤️",
    message:
        "Cheers to your 22nd Ni Happiest Birthday.You’ve truly been the most beautiful thing to ever happen in my life. The way you’ve cared for me, protected me, and loved me filled a space I never thought anyone could. Because of you, I never really felt the absence of a mother’s love you gave me that warmth in your own way. No matter where life takes us, I’ll never forget the basketball court, S Kumar cha table, and all the little moments that became my safest memories because you were there. And Auggie would be so so proud of the person you’ve become. 💕🐾",
  ),
  BirthdayMessage(
    image: "assets/nidhi/messages/komo.jpeg",
    name: "komolika",
    // relation: "Best Friend ❤️",
    message:
        "Hi nidhi I love you You r the stoopidest yet the most loving friend Too much to say m a big yapper But i will stick to I AM VERY PROUD OF YOU and i am always there for you whatever you choose whatever you do in your life i will be theree for you \nXoxo \nI loveee uh",
  ),
  BirthdayMessage(
    image: "assets/nidhi/messages/tanvi.jpeg",
    name: "Tanvi",
    // relation: "Best Friend ❤️",
    message:
        "Hey nidhuu we might not meet every day because of our schedules, but one look at each other is all it takes to understand everything. Cheers to all our childhood memories and the unbreakable bond we share. Love you so much, Bebe! ",
  ),
  BirthdayMessage(
    image: "assets/nidhi/messages/balaji.jpeg",
    name: "Balaji",
    // relation: "Best Friend ❤️",
    message:
        "Happy birthday to my absolute favorite human Life is infinitely brighter, funnier, and more beautiful with you in it Thank you for always being my person. I hope your day is as incredible as your heart is",
  ),
  BirthdayMessage(
    image: "assets/nidhi/messages/divya.jpeg",
    name: "Divya",
    // relation: "Sister 💕",
    message:
        "Happy Birthday to my favorite person to spend break time with 😂🤍 From nonstop gossip and laughing at the dumbest things to hanging out all the time, life at work would honestly be so boring without you. And yes, when we don’t have the same shift, my mood is automatically ruined Thank you for being my comfort person and best friend. I hope this year brings you lots of happiness, success, good food, and less stressful shifts 😂🎂✨",
  ),
  BirthdayMessage(
    image: "assets/nidhi/messages/mansi.jpeg",
    name: "Mansi",
    message:
        "happpyy birthday nidhhii. I'm glad that you came into my life and I'm so grateful for your friendship. Many more trips to come with you guyssss.... I don't care whatever other people say about our friendship ( trio)  I know that our friendship lasts as far as sun rises. Don't give resign soon! For the very first time I love something about indigo because Indigo gives me such a sweetest friend. No matter the situation will be I am always there for you. Lots of loveee 💕",
  ),
];

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
