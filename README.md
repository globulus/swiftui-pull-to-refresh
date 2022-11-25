# SwiftUIPullToRefresh

Pull to refresh is a common UI pattern, supported in UIKit via UIRefreshControl. (Un)surprisingly, it's also unavailable in SwiftUI prior to version 3, and even then [it's a bit lackluster](https://swiftuirecipes.com/blog/pull-to-refresh-with-swiftui-scrollview#drawbacks).

This package contains a component - `RefreshableScrollView`  - that enables this functionality with **any `ScrollView`**. It also **doesn't rely on `UIViewRepresentable`**, and works with **any iOS version**. The end result looks like this:

![in action](https://swiftuirecipes.com/user/pages/01.blog/pull-to-refresh-with-swiftui-scrollview/ezgif-4-bf1673b185d4.gif)

## Features

* Works on any `ScrollView`.
* Customizable progress indicator, with a default `RefreshActivityIndicator` spinner that works on any SwiftUI version.
* Specify refresh operation and choose when it ends.
* Support for Swift 5.5 `async` blocks.
* Compatibility `refreshCompat` modifier to deliver a drop-in replacement for iOS 15 `refreshable`.
* Built-in haptic feedback, just like regular `List` with `refreshable` has.
* Additional optional customizations:
  + `showsIndicators` to allow for showing/hiding `ScrollView` indicators.
  + `loadingViewBackgroundColor` to specify the background color of the progress indicator.
  + `threshold` that indicates how much does the user how to pull before triggering refresh.

## Installation

This component is distrubuted as a **Swift package**. Just add this URL to your package list:

```text
https://github.com/globulus/swiftui-pull-to-refresh
```

You can also use **CocoaPods**:

```ruby
pod 'SwiftUI-Pull-To-Refresh', '~> 1.1.9'
```

## Sample usage

### Bread & butter

```swift
struct TestView: View {
  @State private var now = Date()

  var body: some View {
     RefreshableScrollView(onRefresh: { done in
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          self.now = Date()
          done()
        }
      }) {
        VStack {
          ForEach(1..<20) {
            Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: now)!)")
               .padding(.bottom, 10)
           }
         }.padding()
       }
     }
   }
}
```

### Custom progress view

```swift
RefreshableScrollView(onRefresh: { done in
  DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    self.now = Date()
    done()
  }
},
progress: { state in // HERE
   if state == .waiting {
       Text("Pull me down...")
   } else if state == .primed {
       Text("Now release!")
   } else {
       Text("Working...")
   }
}) {
  VStack {
    ForEach(1..<20) {
      Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: now)!)")
         .padding(.bottom, 10)
     }
   }.padding()
}
```

### Using async block

```swift
 RefreshableScrollView(action: { // HERE
     try? await Task.sleep(nanoseconds: 3_000_000_000)
     now = Date()
 }, progress: { state in
     RefreshActivityIndicator(isAnimating: state == .loading) {
         $0.hidesWhenStopped = false
     }
 }) {
    VStack {
      ForEach(1..<20) {
        Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: now)!)")
           .padding(.bottom, 10)
       }
     }.padding()
   }
 }
```

### Compatibility mode

```swift
  VStack {
      ForEach(1..<20) {
      Text("\(Calendar.current.date(byAdding: .hour, value: $0, to: now)!)")
        .padding(.bottom, 10)
    }
  }
  .refreshableCompat { done in // HERE
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        self.now = Date()
        done()
      }
  } progress: { state in
      RefreshActivityIndicator(isAnimating: state == .loading) {
          $0.hidesWhenStopped = false
      }
  }
```

## Recipe

Check out [this recipe](https://swiftuirecipes.com/blog/pull-to-refresh-with-swiftui-scrollview) for in-depth description of the component and its code. Check out [SwiftUIRecipes.com](https://swiftuirecipes.com) for more **SwiftUI recipes**!

## Changelog

* 1.1.9 - Reworked haptic feedback, added haptic feedback as optional.
* 1.1.8 - Fixed crash when doing two pulls quickly in succession.
* 1.1.7 - Updated haptic feedback. Increased Swift version for Podspec.
* 1.1.6 - Fixed issue where content wouldn't swipe up while in refresh state.
* 1.1.5 - Added smooth animation when loading pull is released.
* 1.1.4 - Added `threshold` and `loadingViewBackgroundColor` customizations.
* 1.1.3 - Add haptic feedback & increase offset a bit to fix indicator being visible on certain iPad Pro models.
* 1.1.2 - Increase offset to fix UI bug occurring on iPhones without notch.
* 1.1.1 - Added `showsIndicators` to allow for showing/hiding `ScrollView` indicators.
* 1.1.0 - Added ability to specify custom progress view, iOS 15 support, async block support and compatibility mode.
* 1.0.0 - Initial release.
