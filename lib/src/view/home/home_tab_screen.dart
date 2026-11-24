import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nf_base/src/styles/lichess_colors.dart';
import 'package:nf_base/src/widgets/adaptive_action_sheet.dart';
import 'package:nf_base/src/widgets/adaptive_choice_picker.dart';
import 'package:nf_base/src/widgets/buttons.dart';
import 'package:nf_base/src/widgets/emoji_picker/emoji_picker.dart';
import 'package:nf_base/src/widgets/emoji_picker/emoji_picker_configuration.dart';
import 'package:nf_base/src/widgets/emoji_picker/emoji_picker_models.dart';
import 'package:nf_base/src/widgets/empty_state_widget.dart';
import 'package:nf_base/src/widgets/platform_avatar.dart';
import 'package:nf_base/src/widgets/platform_card.dart';
import 'package:nf_base/src/widgets/platform_date_picker.dart';
import 'package:nf_base/src/widgets/platform_loading_overlay.dart';
import 'package:nf_base/src/widgets/platform_switch_list_tile.dart';
import 'package:nf_base/src/widgets/platform_text_field.dart';
import 'package:nf_base/src/widgets/progression_widget.dart';
import 'package:nf_base/src/widgets/shimmer.dart';
import 'package:nf_base/src/widgets/stat_card.dart';
import 'package:nf_base/src/widgets/text_badge.dart';
import 'package:nf_base/src/widgets/yes_no_dialog.dart';

class HomeTabScreen extends ConsumerStatefulWidget {
  const HomeTabScreen({super.key});

  @override
  ConsumerState<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends ConsumerState<HomeTabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _shimmerLoading = true;
  String _selectedChoice = 'Premium';
  String _selectedEmoji = 'None';

  bool _switchVal = false;
  DateTime? _selectedDate;
  bool _showOverlay = false;
  final _textController = TextEditingController();

  final List<String> _showcaseChoices = ['Standard', 'Premium', 'Ultimate', 'Enterprise'];

  // Mock EmojiData structure targeting standard web emojis
  static const EmojiData _mockEmojiData = EmojiData(
    categories: [
      Category(id: 'smileys', name: 'Smileys', emojiIds: ['smile', 'wink', 'laugh']),
      Category(id: 'objects', name: 'Objects', emojiIds: ['heart', 'fire', 'thumbsup']),
    ],
    emojis: {
      'smile': Emoji(
        id: 'smile',
        name: 'Smile',
        keywords: {'smile', 'happy', 'face'},
        skins: [Skin(src: 'https://lichess1.org/assets/images/emoji/smile.png')],
      ),
      'wink': Emoji(
        id: 'wink',
        name: 'Wink',
        keywords: {'wink', 'face'},
        skins: [Skin(src: 'https://lichess1.org/assets/images/emoji/wink.png')],
      ),
      'laugh': Emoji(
        id: 'laugh',
        name: 'Laughing',
        keywords: {'laugh', 'lol', 'happy'},
        skins: [Skin(src: 'https://lichess1.org/assets/images/emoji/laughing.png')],
      ),
      'heart': Emoji(
        id: 'heart',
        name: 'Heart',
        keywords: {'heart', 'love'},
        skins: [Skin(src: 'https://lichess1.org/assets/images/emoji/heart.png')],
      ),
      'fire': Emoji(
        id: 'fire',
        name: 'Fire',
        keywords: {'fire', 'hot', 'lit'},
        skins: [Skin(src: 'https://lichess1.org/assets/images/emoji/fire.png')],
      ),
      'thumbsup': Emoji(
        id: 'thumbsup',
        name: 'Thumbs Up',
        keywords: {'thumbsup', 'yes', 'ok'},
        skins: [Skin(src: 'https://lichess1.org/assets/images/emoji/thumbsup.png')],
      ),
    },
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Showcase Gallery'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard_customize), text: 'Components'),
            Tab(icon: Icon(Icons.ads_click), text: 'Pickers & Sheets'),
            Tab(icon: Icon(Icons.emoji_emotions), text: 'Emoji Picker'),
            Tab(icon: Icon(Icons.star), text: 'Adaptive Widgets'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildComponentsTab(theme),
          _buildPickersTab(theme),
          _buildEmojiPickerTab(theme),
          _buildNewWidgetsTab(theme),
        ],
      ),
    );
  }

  Widget _buildComponentsTab(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader(theme, 'Stat Cards (Grid Layout)'),
        const StatCardRow([
          StatCard(
            'Active Users',
            value: '1,248',
            contentPadding: EdgeInsets.all(16.0),
          ),
          StatCard(
            'Status',
            value: 'Online',
            backgroundColor: Color(0x1F009688),
            contentPadding: EdgeInsets.all(16.0),
          ),
        ]),
        const SizedBox(height: 24),

        _buildSectionHeader(theme, 'Badges & Indicators'),
        const Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TextBadge(text: 'NEW', badgeColor: LichessColors.red),
            TextBadge(text: 'STABLE', badgeColor: LichessColors.brag),
            TextBadge(text: 'EXPERIMENTAL', badgeColor: Colors.white, textColor: Colors.black),
            SizedBox(width: 12),
            ProgressionWidget(15, fontSize: 16),
            ProgressionWidget(-8, fontSize: 16),
            ProgressionWidget(0, fontSize: 16),
          ],
        ),
        const SizedBox(height: 24),

        _buildSectionHeader(theme, 'Interactive Shimmer Loader'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Simulate loading state'),
                    Switch.adaptive(
                      value: _shimmerLoading,
                      onChanged: (val) => setState(() => _shimmerLoading = val),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 8),
                Shimmer(
                  child: ShimmerLoading(
                    isLoading: _shimmerLoading,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Loaded Content: Dynamic Data Display',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 150,
                          height: 16,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        _buildSectionHeader(theme, 'Opacity Feedback Button'),
        OpacityButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OpacityButton Pressed!')),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Center(
              child: Text(
                'Press Me (Opacity Feedback)',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPickersTab(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSectionHeader(theme, 'Adaptive Choice Picker'),
        Card(
          child: ListTile(
            title: const Text('Choice Picker Selection'),
            subtitle: Text('Selected: $_selectedChoice'),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: () {
              showChoicePicker<String>(
                context,
                title: const Text('Select a Tier'),
                choices: _showcaseChoices,
                selectedItem: _selectedChoice,
                labelBuilder: (choice) => Text(choice),
                onSelectedItemChanged: (choice) {
                  setState(() => _selectedChoice = choice);
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        _buildSectionHeader(theme, 'Adaptive Action Sheet'),
        Card(
          child: ListTile(
            title: const Text('Trigger Action Sheet'),
            subtitle: const Text('Platform-adaptive actions popup'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () {
              showAdaptiveActionSheet<void>(
                context: context,
                title: const Text('Showcase Actions'),
                actions: [
                  BottomSheetAction(
                    makeLabel: (_) => const Text('Option 1 (Normal)'),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Option 1 Selected')),
                      );
                    },
                  ),
                  BottomSheetAction(
                    makeLabel: (_) => const Text('Option 2 (Destructive)'),
                    isDestructiveAction: true,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Destructive Option Selected')),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        _buildSectionHeader(theme, 'Adaptive Yes/No Dialog'),
        Card(
          child: ListTile(
            title: const Text('Launch Dialog'),
            subtitle: const Text('A standardized Yes/No confirm popup'),
            trailing: const Icon(Icons.question_answer),
            onTap: () {
              showAdaptiveDialog<void>(
                context: context,
                builder: (context) => YesNoDialog(
                  title: const Text('Confirm Action'),
                  content: const Text('Do you want to accept this sample action?'),
                  onYes: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Accepted!')),
                    );
                  },
                  onNo: () => Navigator.pop(context),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmojiPickerTab(ThemeData theme) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Selected Emoji: $_selectedEmoji',
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: EmojiPicker(
            emojiData: _mockEmojiData,
            configuration: const EmojiPickerConfiguration(
              showSearchBar: true,
              showTabs: true,
              perLine: 6,
              emojiSize: 32,
            ),
            onEmojiSelected: (id, src) {
              setState(() => _selectedEmoji = id.toUpperCase());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
      child: Text(
        text,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildNewWidgetsTab(ThemeData theme) {
    return PlatformLoadingOverlay(
      visible: _showOverlay,
      message: 'Loading overlay demo...',
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionHeader(theme, 'Platform Card & Avatar'),
          PlatformCard(
            child: Row(
              children: [
                const PlatformAvatar(
                  initials: 'JD',
                  isOnline: true,
                  size: 50,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Text('Senior Flutter Developer'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(theme, 'Platform Input Elements'),
          PlatformTextField(
            controller: _textController,
            hintText: 'Enter sample text...',
            prefix: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.edit, size: 18),
            ),
          ),
          const SizedBox(height: 12),
          PlatformSwitchListTile(
            value: _switchVal,
            onChanged: (val) => setState(() => _switchVal = val),
            title: const Text('Toggle Adaptive Setting'),
            subtitle: const Text('Renders platform-native switch elements'),
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(theme, 'Platform Date Picker'),
          PlatformCard(
            onTap: () async {
              final picked = await PlatformDatePicker.show(
                context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                setState(() => _selectedDate = picked);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Pick a Date'),
                Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(theme, 'Platform Loading Overlay Toggle'),
          ElevatedButton(
            onPressed: () {
              setState(() => _showOverlay = true);
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  setState(() => _showOverlay = false);
                }
              });
            },
            child: const Text('Trigger Blur Loading Overlay (2s)'),
          ),
          const SizedBox(height: 16),

          _buildSectionHeader(theme, 'Empty State Widget'),
          PlatformCard(
            padding: EdgeInsets.zero,
            child: EmptyStateWidget(
              icon: Icon(Icons.inbox_outlined, size: 48, color: theme.colorScheme.secondary),
              title: const Text('No Items Found'),
              description: const Text('Get started by adding items to your list.'),
              action: ElevatedButton(
                onPressed: () {},
                child: const Text('Create New Item'),
              ),
            ),
          ),
          const SizedBox(height: 200)
        ],
      ),
    );
  }
}
