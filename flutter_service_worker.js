'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "3cabdbf94056c519475bcbd7a8a676e5",
"assets/AssetManifest.bin.json": "625875938b61b4ea36053089d152065b",
"assets/assets/intro.mp4": "979a809d409928134a9a1c8d76bf8ab7",
"assets/assets/movies.json": "4ce006d8d2535127992de50cb8be67f4",
"assets/assets/Netflix_2016_N_logo.png": "824abe0248e0ec03364895d339d3e40c",
"assets/assets/netflix_logo.svg": "6dbba458959d4ce1edd2f5b3ab3ae13b",
"assets/assets/nidhi/featured/preview_thumbnail.png": "d116515466832bda33553dcc1e5a46cb",
"assets/assets/nidhi/Nidhi_Bollywood_Day.mp4": "3e653c98507d85e003e9a7e6146b8fcb",
"assets/assets/nidhi/row1/1.jpg": "86ac5530a265b4a3e73bbe6f724f5558",
"assets/assets/nidhi/row1/2.jpg": "a06186f8e0ff1fbd4660ebef45027726",
"assets/assets/nidhi/row1/3.jpg": "d70e57ecc46c23a5f01cfbf56dbd1dff",
"assets/assets/nidhi/row1/4.jpg": "0aa0b3b1fbb6e6ddcc937ffaa9465d8f",
"assets/assets/nidhi/row1/5.jpg": "dbf552c25cb06269a1abe892046a17fd",
"assets/assets/nidhi/row1/6.jpg": "1964ff637abb722896b43d9de6ed8ab2",
"assets/assets/nidhi/row1/7.jpg": "d077dd3b796752cf8f6bd771c79e56c7",
"assets/assets/nidhi/row1/8.jpg": "d2f6e42403c3990b29a0816119ce4275",
"assets/assets/nidhi/row2/1.jpg": "62a58ba5adc94e37740f6d28636b945a",
"assets/assets/nidhi/row2/2.jpg": "ac5abd5de11e5cfe11b6804e9af78846",
"assets/assets/nidhi/row2/3.jpg": "6f7f722e6f9545ba76d5dbd1234af169",
"assets/assets/nidhi/row2/4.jpg": "69c0303a56a4f6b418b6cd953da96185",
"assets/assets/nidhi/row2/5.jpg": "caeea33e26579005814ddd6154bd12f9",
"assets/assets/nidhi/row2/6.jpg": "21b93f2a24718cb5d33a8112ad280f98",
"assets/assets/nidhi/row2/7.jpg": "db207c569cd91610f16e219100baa5ef",
"assets/assets/nidhi/row2/8.jpg": "a09bfcc42310136e132edcc2cb8c7a07",
"assets/assets/nidhi/row3/1.jpg": "766891f4445ee4d68a111d1ae5fd8c3e",
"assets/assets/nidhi/row3/2.jpg": "ee9aa2e14260fc7507620608bc048ac3",
"assets/assets/nidhi/row3/3.jpg": "c7f224988e84864755aa5cdb009bccf2",
"assets/assets/nidhi/row3/4.JPG": "193f1064f7c177053908067363244de2",
"assets/assets/nidhi/row3/5.JPG": "fb6b1ba5fbce77121d81063ece3c4c6d",
"assets/assets/nidhi/row3/6.jpg": "ce2815947f52331cce2e7b6cb7b9b888",
"assets/assets/nidhi/row3/7.jpg": "4e596cab897bf4632894a41f1c6221d4",
"assets/assets/nidhi/row3/8.jpg": "a1b166fd947eab0c26dc52d9f9e43a10",
"assets/assets/nlogo.webp": "c4fd78bcd2d92d2be422df1dd73054b0",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "7d75012d86ab411f5808a3750154437e",
"assets/NOTICES": "5476b63fc527ee54a2359568991a90a5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "f0f0c60131298df2d510c80f6c0aa2b7",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "174f22539341e51f65e4d96e81c397e1",
"/": "174f22539341e51f65e4d96e81c397e1",
"main.dart.js": "eea96312934d977706a38ad3e365507f",
"manifest.json": "dc97eeeb72daa6532c3da12dd67bdee4",
"version.json": "a5e46c1341e78ae0c36864634fe6c2cf"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
