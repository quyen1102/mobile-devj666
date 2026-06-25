# Scout Report: Remaining Chess & Lichess Dependencies in Core Codebase

This report lists the remaining chess-specific files, imports, and variables that need to be removed or refactored during Phase 2.

## Key Findings

### 1. Chess-specific Widget Files
- [lib/src/widgets/material_diff.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/material_diff.dart): Displays material difference. To be deleted.
- [lib/src/widgets/side_indicator.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/side_indicator.dart): Displays chess side. To be deleted.

### 2. Orphaned Services & Models
- [lib/src/model/chat/](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/model/chat/): Game/tournament chat. To be deleted.
- [lib/src/model/common/service/move_feedback.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/model/common/service/move_feedback.dart): Game move feedback. To be deleted.
- [lib/src/shared_pgn_service.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/shared_pgn_service.dart): Imports non-existent `ImportPgnScreen`. To be deleted.
- [lib/src/model/settings/board_preferences.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/model/settings/board_preferences.dart): Chess board styles & preferences. To be deleted.

### 3. Files with Chess Imports & Dependencies
- [lib/src/app.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/app.dart):
  - Imports `board_preferences.dart`, `shared_pgn_service.dart`, `challenge_service.dart`, `correspondence_service.dart`, etc.
  - Calls `makeAppTheme` with `boardPrefs` (which needs to be removed).
  - Initializes chess background services.
- [lib/src/quick_actions.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/quick_actions.dart):
  - Imports `game_seek.dart`, `puzzle_theme.dart`, etc.
  - Hardcodes chess seeks and offline computer/puzzle actions. Should be refactored to generic shortcut template.
- [lib/src/app_links_service.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/app_links_service.dart):
  - Resolves puzzle, tournament, study, analysis, and TV links. Needs to be replaced with generic deep-linking skeleton.
- [lib/src/model/common/service/sound_service.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/model/common/service/sound_service.dart):
  - Imports missing `sound_effect` plugin. Must be mocked out.
- [lib/src/view/message/conversation_screen.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/view/message/conversation_screen.dart):
  - Imports `chat_context_menu.dart` which is deleted. Needs replacement with a native Flutter context menu.
- [lib/src/widgets/misc.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/misc.dart):
  - Defines `AppBarLichessTitle` and `LichessMessage` containing Lichess copy. Should be made generic.
