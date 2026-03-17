# AGENTS.md — iNewshub iOS Agent Guide

## Project Overview

SwiftUI iOS client for the iNewshub platform.
Consumes the iNewshub REST API v2 at https://seevsk.alwaysdata.net/inewshub/v2

- **Language:** Swift
- **Framework:** SwiftUI
- **Networking:** URLSession (native, no third-party libraries)
- **Maps:** Google Maps SDK
- **Images:** AsyncImage consuming full Cloudinary URLs from the API

---

## Instructions for agents

- **Respond always in Spanish** — the user speaks Spanish
- Code and comments always in English
- Advance step by step — explain each file/change before writing it
- The user authorizes every commit — never commit without authorization
- Always provide commit message + Spanish translation before asking for authorization
- One commit per logical change — never bundle unrelated files
- No third-party networking libraries — use URLSession natively
- Follow SwiftUI declarative patterns — no UIKit unless strictly necessary

---

## API Connection

- Base URL: `https://seevsk.alwaysdata.net/inewshub/v2`
- Auth: Bearer Token in Authorization header
- Token obtained via `POST /auth/login`
- Token stored locally after login

## Image System

- All images served from Cloudinary CDN
- API returns full URLs in `hero_image` and `image_url` fields
- Consume directly: `AsyncImage(url: URL(string: item.hero_image))`
- No URL construction needed — do NOT hardcode base URLs for images

---

## Project Structure

inewshub/
├── Pages/ # Primary screens — AllView, NewsView, ArticleDetailView, EventsView
├── SubsectionsLife/ # FacilitiesView, SeminarsView, SocietiesView, GreenView
├── ViewModels/ # UsersApiManager and other API managers
├── Model/ # Articles, Facilities, Users, RegisterResponse
├── Components/ # SectionButton, SectionTab, StartButton
├── Utils/
│ ├── Constants.swift # API base URL — single source of truth
│ └── Functions/ # DateFormatter, TimeDays
├── BaseLocal/ # Local news: NewsLocal, FavoritesView, AddNewsLocalView
├── GoogleMaps/ # AppDelegate (Maps key), GoogleMapView
├── NavigationBottom/ # UsersView, UsersUpdateView
├── ContentView.swift
├── DashboardView.swift
├── LoginView.swift
├── RegisterView.swift
├── LaunchScreen.swift
└── inewshubApp.swift

---

## Permission Map (from API)

User → read content, GET /me, PATCH /me/password
Editor → same as User + POST/PUT/DELETE own articles
Admin → everything including Users CRUD

## Endpoints Consumed

GET /articles public — ?type, ?q
GET /articles/{slug} public
GET /facilities public
GET /facilities/{slug} public
GET /history public
GET /history/{slug} public
GET /sites public — ?category, ?sort
GET /sites/{slug} public
POST /auth/login public
POST /auth/logout public
GET /me auth
PATCH /me/password auth
GET /me/articles auth

---

## Related Repositories

- API backend: https://github.com/inewshub/api
- Web panel: https://github.com/inewshub/web
- Android client: https://github.com/inewshub/android
- Flutter client: https://github.com/inewshub/flutter

---

## Git Conventions

Commit message format: `type(scope): description`
Common types: `feat`, `fix`, `chore`, `refactor`, `wip`, `docs`
Branch: `main`
