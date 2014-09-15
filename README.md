Demonstates offline caching using the URL loading system.

Start the application and touch the "Fetch" button. This will get a remote JSON file, which will be cached and persisted locally.
Flip the "Offline" switch and touch "Fetch" again. The application uses the cached data, and does not need to go over the network. The code is still making a URL connection, it is just returning almost immediately because it is being served from the cache.