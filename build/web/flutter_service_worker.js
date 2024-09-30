'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e825608a00e90478e1ea3543567070c8",
"assets/AssetManifest.bin.json": "981e6684c818157b22fd49397bddc5b0",
"assets/AssetManifest.json": "29ee8ada526a06f8bcac5be8f672806f",
"assets/assets/images/ai_avatar.svg": "60d8090499d2b5fbf491130394ec2c20",
"assets/assets/images/apple.svg": "00587615733dd4954be85d8bf79f1d6f",
"assets/assets/images/chat.svg": "2644ebb0ed3b82f7f08fa5aa9df05bd4",
"assets/assets/images/clipboard.svg": "835cb0da3c66a34c84f7fc80958c5965",
"assets/assets/images/copy.svg": "f1534ec4c8636e7e3e4c4afafc434a85",
"assets/assets/images/date.svg": "20a532794602131e421d2ffe080bffe6",
"assets/assets/images/delete.svg": "4b4e97c3f5b5c2f36e29789247fbc527",
"assets/assets/images/dislike.svg": "593310a27c1f47b7d4dac74c0055630c",
"assets/assets/images/edit.svg": "36d5421bed356e642c769527495e81ca",
"assets/assets/images/filter.svg": "18f3ab7d8d3b7f54af616ef780b27927",
"assets/assets/images/google.svg": "0447c7bec2caf670c39d86feedcd0eaf",
"assets/assets/images/grid.svg": "af72f7fcf92151466b73e8de106edb12",
"assets/assets/images/like.svg": "af53999199d4e6580cfb7c2b641bc55a",
"assets/assets/images/logo.png": "73cb4ef8759d9b369078d4af89bf05fa",
"assets/assets/images/logo.svg": "c227ed49aa6924b2b3e28365238e29a2",
"assets/assets/images/logout.svg": "82d432808c206039e58d78adff3aa612",
"assets/assets/images/pdf.svg": "f540a2cee2b0018a810b818d0f7331f9",
"assets/assets/images/pdf_green.svg": "115f2bf6c883112db967b6331fcdbd67",
"assets/assets/images/pin.svg": "0840f458f50383f3a5b2dae17840e2a1",
"assets/assets/images/plus.svg": "85c127229819af93077174e8fc5e476a",
"assets/assets/images/power.svg": "ae7ffa6c30d67deedf4161fb660929cf",
"assets/assets/images/pro.svg": "0bec8c4460a2fa2dfddef7e455612409",
"assets/assets/images/refresh.svg": "5b7f310fd5daa9199ec3c30180607487",
"assets/assets/images/reset.svg": "a58c20db951e2e774e416acbd7fc295f",
"assets/assets/images/send.svg": "63c32e6f75aa8662a351a2508db561b6",
"assets/assets/images/setting.svg": "f24be8c46725f18cc20fff590d5bd1c6",
"assets/assets/images/sort.svg": "19d634247c3f0a6d5e2a59b45559a786",
"assets/assets/images/users.svg": "7b31aea20e4db38cdf7026cd6fbafef1",
"assets/assets/json/loader.json": "e70c16f368cc65277d4c7e1236565bd5",
"assets/assets/json/nodata.json": "757e7af7ec78258c82dcd57081a51e29",
"assets/FontManifest.json": "ac3f70900a17dc2eb8830a3e27c653c3",
"assets/fonts/MaterialIcons-Regular.otf": "1f9a318a5a7cd09163329c2fbed03afe",
"assets/NOTICES": "b64937239cb686bfbda35c1e74791997",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "75b20e501d7bf8ccecfa37ab3c51d924",
"assets/packages/syncfusion_flutter_datagrid/assets/font/FilterIcon.ttf": "b8e5e5bf2b490d3576a9562f24395532",
"assets/packages/syncfusion_flutter_datagrid/assets/font/UnsortIcon.ttf": "acdd567faa403388649e37ceb9adeb44",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "adaca0f7c67feae088c62e342c909301",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "77f108c8ea660808cc88a0361d1baf3b",
"/": "77f108c8ea660808cc88a0361d1baf3b",
"main.dart.js": "a8611132561ed38cdf16e3423b628535",
"manifest.json": "eb989b6ef08a87e001b57629d4715e52",
"version.json": "a3d261fa06836d5541ddff2e1b006d03"};
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
