# Pixellabs — Reference-data management prototype

**Flutter / Dart · 2021 · Historical project**

A Flutter application exploring the import and management of reference data related to French **OPCO**, collective agreements (*conventions collectives*) and **APE codes**.

> **Status:** Early prototype, **not currently maintained**. The repository has not been validated against a modern Flutter SDK. It is **not recommended for use with real or sensitive data** without reviewing its Firestore access rules, data-write behavior and dependencies.

## What the code does

- Provides screens for OPCO, collective-agreement and APE-code information
- Supports selecting and processing CSV files
- Includes forms and actions to add, edit and view records
- Uses **Firebase Cloud Firestore** for its database operations

**Correction:** The original README described a MongoDB database, but the checked-in Dart code uses **Cloud Firestore** (`cloud_firestore`), not MongoDB.

## Stack

- Flutter and Dart
- Firebase Core / Cloud Firestore
- CSV and file-picker packages

Relevant files: [`lib/main.dart`](lib/main.dart), [`lib/Liste_des_opco/`](lib/Liste_des_opco), [`lib/Liste_des_conventions/`](lib/Liste_des_conventions) and [`pubspec.yaml`](pubspec.yaml).

## Limitations

- The original Dart SDK constraint is **`>=2.12.0 <3.0.0`**; modern Flutter compatibility has not been verified.
- The included widget test is a starter-counter template and **does not validate this application's functionality**.
- Firebase configuration, access permissions and import/write behavior would need review before actual use.
- No verified current deployment or working build is claimed.

This repository is retained as an example of an **early Flutter/data-interface experiment**, rather than a current production application. For more representative recent work, visit [my GitHub profile](https://github.com/matheovitali).
