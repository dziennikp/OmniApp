# Overview

Sample app fetching news from http://omni-content.omni.news/
based on searching query. News are displayed in list view with possibility to show details of given article or topic.

# Installation
To install and use app use Cocoapods

```ruby
  cd OmniApp
  pod install
```

# Technical overview
## Used frameworks
- ReSwift
- Texture
- PromiseKit
- OHHTTPStubs (for testing purpose)

## Architecture

Application uses `Redux` as its architecture pattern. `SceneDelegate` creates and holds reference to `AppRouter` and `AppStore`.
`AppRouter` displays `UISplitViewController` with primary controller `ListScreenViewController` and reacts to `SelectedNewsState` in order to display details of selected article/topic.

`ListScreenViewController` serves as main UIViewController, which displays: `Article/Topic` switch, `SearchBar` and `SearchResultsList` which is `ASTableNode`. `SearchResultsList` is updated with an API response based on `SearchBar` text (searching is performed after 0.5 when user stops typing in order to reduce network usage).

Upon selecting given article or topic, details view controller is updated with new data via `Action`.
Changing `Article/Topic` switch results with different type of cell displayed.

`NewsService` is responsible for handling API call.

## Supported devices

App runs on iPad and iPhones (with/without Notch) with iOS 13 and above.

## Potential improvements

- Writing UI and Integration tests
- Using `middleware` for API calls
- Using more `Dependency Injections`
- Providing `ViewModel` and/or `Coordinator` pattern in order to reduce logic in `ViewControllers`
- Changing `ListScreenViewController` to some generic `ViewController` based on `DataSource` and `CellType`, to remove all of switches over `displayType`
- Add CI - Fastlane gym and scan 
