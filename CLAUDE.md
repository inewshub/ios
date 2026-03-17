# iNewshub iOS — Guide for Claude

## What is this project

SwiftUI iOS client for the iNewshub platform.
Part of the iNewshub ecosystem — see https://github.com/inewshub for all repositories.

---

## Tech Stack

| Layer      | Technology                   |
| ---------- | ---------------------------- |
| Language   | Swift                        |
| Framework  | SwiftUI                      |
| Networking | URLSession (native)          |
| Maps       | Google Maps SDK              |
| Images     | AsyncImage + Cloudinary URLs |

---

## API

- Base URL: `https://seevsk.alwaysdata.net/inewshub/v2`
- Auth: Bearer Token
- Full API documentation: https://github.com/inewshub/api

---

## Image System

All images come from Cloudinary as full URLs.
Consume directly — no base URL construction:

```swift
// Correct
AsyncImage(url: URL(string: item.hero_image))
// Wrong — do not do this
AsyncImage(url: URL(string: "https://...alwaysdata.net/drawable/\(type)/\(item.hero_image)"))
---
Key Files
File
Utils/Constants.swift
inewshubApp.swift
DashboardView.swift
LoginView.swift
Pages/AllView.swift
Pages/NewsView.swift
Pages/ArticleDetailView.swift
SubsectionsLife/FacilitiesView.swift
GoogleMaps/GoogleMapView.swift
ViewModels/UsersApiManager.swift
---
## Current Status
- SwiftUI project from institute — functional but not deployed
- App Store deployment out of scope (Apple Developer $99/year)
- Image URLs need to be updated to consume Cloudinary URLs directly
- Part of a multi-repo architecture — see https://github.com/inewshub
---
Coding Conventions
- No third-party networking — URLSession only
- Declarative SwiftUI patterns
- Code and comments in English
- Responses to user always in Spanish
- See AGENTS.md for full agent instructions
```
