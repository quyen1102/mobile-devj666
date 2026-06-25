---
title: "Rename Project to nf_base"
description: "Rename the Flutter package name to nf_base and Android/iOS application package IDs to com.example.base."
status: "completed"
priority: "high"
effort: "medium"
branch: "feature/rename-project"
tags: ["rename", "configuration", "base-app"]
created: "2026-06-25"
---

# Rename Project Plan

Detailed plan to migrate all imports and package configs.

## Phases
1. **[Phase 1: Package and Import Renaming](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/260625-1717-rename-project/phase-01-rename-package.md)** - *Completed*
   - Change package name in `pubspec.yaml`.
   - Rename all `package:lichess_mobile/` imports to `package:nf_base/` in Dart.
   - Run `change_app_package_name` to change native package ID to `com.example.base`.
   - Update Xcode bundle ID and display name configs.
   - Clean up cached build files and run code generation.
