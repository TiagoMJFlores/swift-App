# swiftapp

 swiftapp

iOS take-home exercise consuming the [DummyJSON Products API](https://dummyjson.com/docs/products), built around Clean Architecture, MVVM at the Presentation layer, and Swift 6 strict concurrency.

## Requirements

- Xcode 26
- iOS 17+ deployment target
- Swift 6.3

## External Libraries

| Library | Role |
| --- | --- |
| [GRDB](https://github.com/groue/GRDB.swift) | Local persistence (SQLite). Value-type records, `Sendable`-clean concurrency model, Swift 6-friendly. |
| [Kingfisher](https://github.com/onevcat/Kingfisher) | Async image loading and caching for the product list and detail screens. |
| [swift-dependencies](https://github.com/pointfreeco/swift-dependencies) | Dependency injection. 

No networking library — `URLSession` + `Codable` is enough for the API surface here.

## Build & Run

The project ships with **two schemes**, mapping to the two execution modes required by the brief:

| Scheme         | What it shows                              |
| -------------- | ------------------------------------------ |
| `ListFeature`  | Product listing + detail (no form)         |
| `FormFeature`  | Validated form                             |

To run:

1. Open `swiftapp.xcodeproj` in Xcode 26.
2. Select the desired scheme (`ListFeature` or `FormFeature`) in the toolbar.
3. Pick a simulator (any size — UI is responsive) and run.

External package dependencies are resolved automatically by Swift Package Manager on first build.

## Implemented Features

### Feature 1 — Product Listing with Local Cache
- Fetches all products from `https://dummyjson.com/products` on first launch.
- Persists to GRDB; subsequent launches read from local storage.
- Download is restartable: if interrupted (force-quit, network drop), it resumes on next launch via a `SyncState` table.
- List shows title, rating, and a per-bucket icon (rating <3, 3–4, >4).

### Feature 2 — Real-time Search
- Search bar at the top of the listing.
- Tokenized matching: case-insensitive, diacritic-insensitive, out-of-order terms, partial words.
- Example: `"galaxy samsung"` or `"smart gal"` matches `"Smartphone Samsung Galaxy"`.

### Feature 3 — Product Detail
- Tap a list item to navigate to detail.
- Shows title, price, discount %, stock, rating, main image.
- Image is anchored to the top with a minimum height and stretches/parallaxes on scroll.

### Feature 4 — Validated Form
- Six fields (name, email, number, promo code, delivery date, rating).
- Per-field validation runs on every keystroke via a Combine pipeline.
- Submit is enabled only when all fields are valid.
- Validations match the brief verbatim (date can't be Monday or future, promo code 3–7 chars, uppercase + hyphens, no diacritics, etc.).

**Main Technical Decisions**


**1) Choosing a Clean Architecture Flavor**
I went with a more pragmatic Clean Architecture rather than a strict variant like VIPER:  Presentation can use Domain models directly when shapes match, and I keep layering only as deep as the actual logic demands. Happy to walk through the reasoning in the interview.

**2) Handling Swift 6's Strict Concurrency Model**
Swift 6 makes data-race safety a compile-time guarantee. Apps still on older Swift versions will eventually have to migrate, and that migration can be painful. Given how important this is, I wanted to tackle it head-on in this exercise.

Picking the database was one of the bigger calls on this exercise, since caching was part of the requirements. 
GRDB over SwiftData / Core Data: picked for a clean Swift 6 strict-concurrency story (Sendable primitives, value-type records) and for being battle-tested. Happy to discuss further in the interview.

swift-dependencies (Point-Free) over Other dependency injection frameworks: the only Swift DI library built on @TaskLocal, which keeps overrides isolated per Task and stays parallel-safe under Swift Testing. Container-based alternatives mutate shared state:  for example, a parameterized test of a feature flag races on Container.shared:

```swift
@Test(arguments: [
    FeatureFlags(newCheckoutEnabled: true),
    FeatureFlags(newCheckoutEnabled: false)
])
func checkout(flags: FeatureFlags) {
    Container.shared.register(.flags) { flags }  // both iterations write here in parallel → race
    let viewModel = CheckoutViewModel()
}
```

With swift-dependencies, withDependencies { $0.featureFlags = flags } writes into a @TaskLocal instead: each parallel iteration has its own context, no shared mutation, no race. 

**3) Where Combine is worth it (and where it isn't)**
I initially adopted @Observable on the form and AsyncStream (https://github.com/apple/swift-algorithms) on the listing, then deliberately reverted both: the potential gains didn't justify the migration in this context. Of course architecture choices like this are always project-dependent, and a take-home exercise can't fully capture the constraints of a real codebase. Happy to walk through the reasoning in the interview.

## What I'd Improve with More Time

 **Coordinator pattern for navigation** — likely SwiftUI views hosted inside a UIKit-based coordinator. This would move navigation state out of the views and into a single coordinator object, giving finer-grained control over flow and keeping views purely declarative. 
 
**Unit tests with Swift Testing** — the validators, mappers, repository, and search worker are all pure or protocol-driven, so unit tests would be cheap to add. With Swift Testing's parallel-by-default model and swift-dependencies' `withDependencies` already in place, parameterized tests for validation rules and search tokenization would land easily.

