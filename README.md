<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

Dart abstraction over the BeaconCRM API.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

Install the package:

```
dart pub add beacon_client
```

## Usage


```dart
import 'package:beacon_client/beacon_client.dart';
final crm = BeaconService(
        accountId: beaconOrgId,
        apiKey: Env.apiKey,
      );
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
