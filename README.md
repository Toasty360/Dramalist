# DramaList Scraper

This is a **Dart-based DramaList Scraper** designed to interact with an API (or a scraping service) to fetch data on dramas and movies. It provides various methods to retrieve information about dramas, including upcoming releases, popular content, and more.

## Table of Contents

- [Overview](#overview)
- [Classes](#classes)
  - [DramaList](#dramalist)
  - [Drama](#drama)
  - [DramaCatalog](#dramacatalog)
- [Methods](#methods)
  - [getPreview](#getpreview)
  - [search](#search)
  - [getDramas](#getdramas)
  - [info](#info)
  - [schedule](#schedule)

## Overview

The **DramaList Scraper** is a library for interacting with a platform that provides information about dramas, movies, and variety shows. It allows you to:

- Fetch previews of dramas.
- Search for specific dramas.
- Retrieve lists of upcoming and popular content.
- Get detailed information about a specific drama.
- Get a schedule of dramas by day.

This scraper is useful for gathering information on dramas and movies, keeping track of upcoming releases, or building a personal drama catalog.

## Classes

### DramaList

The **DramaList** class provides methods to fetch information about dramas. It contains asynchronous methods for getting data on specific dramas, searching, and retrieving schedules.

#### Methods:

- **getPreview(int id)**: Fetches a preview of a drama based on the provided `id`. Returns a `Future<Drama>`.
- **search(String query)**: Searches for dramas based on a query string. Returns a `Future<List<Drama>>`.
- **getDramas(DramaCatalog catalog)**: Fetches a list of dramas based on a specified catalog type. Returns a `Future<List<Drama>>`.
- **info(String path)**: Fetches detailed information about a specific drama based on a given path. Returns a `Future<Drama>`.
- **schedule()**: Returns the drama schedule, mapping each day of the week to a list of dramas airing that day. Returns a `Future<Map<int, List<Drama>>>`.

### Drama

The **Drama** model represents a single drama. This class holds the details of each drama, such as title, description, release date, and other related data.

### DramaCatalog Enum

The **DramaCatalog** enum defines the categories of dramas you can retrieve using the `getDramas` method. The possible values are:

- **upcomingMovies**: Movies that are scheduled to be released soon.
- **upcomingDramas**: Dramas that are scheduled to be released soon.
- **popularMovies**: Movies that are currently popular.
- **popularDramas**: Dramas that are currently popular.
- **varietyShows**: Various types of variety shows.

## Methods

### getPreview(int id)

Fetches a preview of a drama using its unique `id`. This method returns a `Future<Drama>` containing the preview data.

```dart
Drama preview = await DramaList.getPreview(123);
```

### search(String query)

Searches for a list of dramas based on a search query. This method returns a `Future<List<Drama>>` containing the search results.

```dart
List<Drama> dramas = await DramaList.search("My Demon");

```

### getDramas(DramaCatalog catalog)

Fetches a list of dramas based on the selected DramaCatalog. This method returns a `Future<List<Drama>>`.

```dart
List<Drama> upcomingDramas = await DramaList.getDramas(DramaCatalog.upcomingDramas);
```

### info(String url)

Fetches detailed information about a specific drama using a path identifier. This method returns a `Future<Drama>` containing the detailed info.

```dart
Drama dramaDetails = await DramaList.info("some-drama-path");
```

### schedule()

Fetches the schedule of dramas by day. This method returns a `Future<Map<int, List<Drama>>>``, where the key is the day of the week (1-7, corresponding to Monday-Sunday) and the value is a list of dramas airing on that day.

```dart
Map<int, List<Drama>> dramaSchedule = await DramaList.schedule();
```
