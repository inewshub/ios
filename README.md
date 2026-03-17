# iNewshub iOS

SwiftUI client application for the iNewshub platform.
This app consumes the iNewshub REST API and focuses on content browsing,
authentication, and role-aware user features.

## Overview

iOS frontend built with SwiftUI as part of the iNewshub ecosystem.
The app connects to the iNewshub REST API to display news, events, seminars,
societies, facilities, history and sites content.

- **Platform:** iOS (SwiftUI)
- **API:** https://seevsk.alwaysdata.net/inewshub/v2
- **Auth:** Bearer Token (login/logout flow)
- **Status:** Work in progress — App Store deployment out of scope for now

## Related Repositories

| Repo                                                    | Description                     |
| ------------------------------------------------------- | ------------------------------- |
| [inewshub/api](https://github.com/inewshub/api)         | PHP REST API backend            |
| [inewshub/web](https://github.com/inewshub/web)         | Next.js web panel (in progress) |
| [inewshub/android](https://github.com/inewshub/android) | Android client (planned)        |
| [inewshub/flutter](https://github.com/inewshub/flutter) | Flutter client (planned)        |

## Tech Stack

- Swift
- SwiftUI
- URLSession — native networking
- AsyncImage — remote image loading
- Google Maps SDK — location display for sites and facilities

## Project Structure

inewshub/
├── Pages/ # Primary content screens
├── SubsectionsLife/ # Life at Lima subsection views
├── ViewModels/ # UI state and API calls
├── Model/ # Data models
├── Components/ # Reusable UI components
├── Utils/ # Constants and helper functions
├── BaseLocal/ # Local storage features
├── GoogleMaps/ # Google Maps integration
├── NavigationBottom/ # Bottom navigation views
└── Assets.xcassets/ # App icons, colors, images

## API Endpoints Used

**Public:**

- `GET /articles` — supports `?type=news|event|seminars|societies` and `?q=search`
- `GET /articles/{slug}`
- `GET /facilities`
- `GET /facilities/{slug}`
- `GET /history`
- `GET /history/{slug}`
- `GET /sites` — supports `?category=lakes|mountains|dams` and `?sort=asc|desc`
- `GET /sites/{slug}`
  **Authenticated:**
- `POST /auth/login`
- `POST /auth/logout`
- `GET /me`
- `PATCH /me/password`
- `GET /me/articles`

## Setup

1. Clone this repository
2. Open `inewshub.xcodeproj` in Xcode
3. Verify the API base URL in `Utils/Constants.swift`
4. Add your Google Maps API key in `GoogleMaps/AppDelegate.swift`
5. Build and run on simulator or physical iPhone (iOS 16+)

## Notes on Images

Images are served from Cloudinary CDN.
The `hero_image` and `image_url` fields in the API return full Cloudinary URLs.
Use `AsyncImage(url: URL(string: item.hero_image))` directly — no URL construction needed.
