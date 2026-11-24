// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class AppIcons {
  static bool get _isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  // ── Navigation & Control ──────────────────────────────────────────────────
  static IconData get close => _isIOS ? CupertinoIcons.xmark : Icons.close_rounded;
  static IconData get back => _isIOS ? CupertinoIcons.arrow_left : Icons.arrow_back_rounded;
  static IconData get backIos => _isIOS ? CupertinoIcons.arrow_left : Icons.arrow_back_ios_new_rounded;
  static IconData get arrowBackOutlined => _isIOS ? CupertinoIcons.arrow_left : Icons.arrow_back_outlined;
  static IconData get forward => _isIOS ? CupertinoIcons.arrow_right : Icons.arrow_forward_rounded;
  static IconData get chevronRight => _isIOS ? CupertinoIcons.chevron_right : Icons.chevron_right_rounded;
  static IconData get chevronLeft => _isIOS ? CupertinoIcons.chevron_left : Icons.chevron_left_rounded;
  static IconData get chevronDown => _isIOS ? CupertinoIcons.chevron_down : Icons.keyboard_arrow_down_rounded;
  static IconData get chevronUp => _isIOS ? CupertinoIcons.chevron_up : Icons.keyboard_arrow_up_rounded;
  static IconData get expandMore => _isIOS ? CupertinoIcons.chevron_down : Icons.expand_more_rounded;
  static IconData get arrowDropDown => _isIOS ? CupertinoIcons.chevron_down : Icons.arrow_drop_down_rounded;
  static IconData get moreVert => _isIOS ? CupertinoIcons.ellipsis_vertical : Icons.more_vert_rounded;
  static IconData get settings => _isIOS ? CupertinoIcons.gear_alt : Icons.settings_rounded;
  static IconData get add => _isIOS ? CupertinoIcons.add : Icons.add_rounded;
  static IconData get addCircle => _isIOS ? CupertinoIcons.add_circled : Icons.add_circle_outline_rounded;
  static IconData get remove => _isIOS ? CupertinoIcons.minus : Icons.remove;
  static IconData get removeCircle => _isIOS ? CupertinoIcons.minus_circled : Icons.remove_circle_outline_rounded;
  static IconData get refresh => _isIOS ? CupertinoIcons.refresh : Icons.refresh_rounded;
  static IconData get tune => _isIOS ? CupertinoIcons.slider_horizontal_3 : Icons.tune_rounded;
  static IconData get filter => _isIOS ? CupertinoIcons.slider_horizontal_3 : Icons.filter_list;

  // ── Status & Feedback ─────────────────────────────────────────────────────
  static IconData get check => _isIOS ? CupertinoIcons.checkmark : Icons.check_rounded;
  static IconData get checkCircle => _isIOS ? CupertinoIcons.checkmark_circle_fill : Icons.check_circle_rounded;
  static IconData get checkCircleOutline => _isIOS ? CupertinoIcons.checkmark_circle : Icons.check_circle_outline_rounded;
  static IconData get warning => _isIOS ? CupertinoIcons.exclamationmark_triangle_fill : Icons.warning_rounded;
  static IconData get warningAmber => _isIOS ? CupertinoIcons.exclamationmark_triangle : Icons.warning_amber_rounded;
  static IconData get error => _isIOS ? CupertinoIcons.exclamationmark_circle_fill : Icons.error_rounded;
  static IconData get errorOutline => _isIOS ? CupertinoIcons.exclamationmark_circle : Icons.error_outline_rounded;
  static IconData get info => _isIOS ? CupertinoIcons.info_circle_fill : Icons.info_rounded;
  static IconData get infoOutline => _isIOS ? CupertinoIcons.info_circle : Icons.info_outline_rounded;
  static IconData get block => _isIOS ? CupertinoIcons.xmark_circle : Icons.block_rounded;

  // ── Finance & Money ───────────────────────────────────────────────────────
  static IconData get wallet => _isIOS ? CupertinoIcons.creditcard : Icons.account_balance_wallet_rounded;
  static IconData get walletOutlined => _isIOS ? CupertinoIcons.creditcard : Icons.account_balance_wallet_outlined;
  static IconData get savings => _isIOS ? CupertinoIcons.money_dollar_circle : Icons.savings_rounded;
  static IconData get savingsOutlined => _isIOS ? CupertinoIcons.money_dollar_circle : Icons.savings_outlined;
  static IconData get creditCard => _isIOS ? CupertinoIcons.creditcard : Icons.credit_card;
  static IconData get attachMoney => _isIOS ? CupertinoIcons.money_dollar : Icons.attach_money_rounded;
  static IconData get receiptLong => _isIOS ? CupertinoIcons.doc_text : Icons.receipt_long_rounded;
  static IconData get receiptLongOutlined => _isIOS ? CupertinoIcons.doc_text : Icons.receipt_long_outlined;
  static IconData get trendingUp => _isIOS ? CupertinoIcons.arrow_up_right : Icons.trending_up_rounded;
  static IconData get trendingDown => _isIOS ? CupertinoIcons.arrow_down_right : Icons.trending_down_rounded;
  static IconData get arrowUpward => _isIOS ? CupertinoIcons.arrow_up : Icons.arrow_upward_rounded;
  static IconData get arrowDownward => _isIOS ? CupertinoIcons.arrow_down : Icons.arrow_downward_rounded;
  static IconData get paid => _isIOS ? CupertinoIcons.money_dollar_circle_fill : Icons.paid_rounded;
  static IconData get payments => _isIOS ? CupertinoIcons.money_dollar_circle : Icons.payments_outlined;
  static IconData get currencyExchange => _isIOS ? CupertinoIcons.arrow_2_squarepath : Icons.currency_exchange_rounded;
  static IconData get swapHoriz => _isIOS ? CupertinoIcons.arrow_right_arrow_left : Icons.swap_horiz_rounded;
  static IconData get swapVert => _isIOS ? CupertinoIcons.arrow_up_arrow_down : Icons.swap_vert_rounded;

  // ── Actions & Content ─────────────────────────────────────────────────────
  static IconData get search => _isIOS ? CupertinoIcons.search : Icons.search_rounded;
  static IconData get searchOff => _isIOS ? CupertinoIcons.xmark_circle_fill : Icons.search_off_rounded;
  static IconData get edit => _isIOS ? CupertinoIcons.pencil : Icons.edit_rounded;
  static IconData get editOutlined => _isIOS ? CupertinoIcons.pencil : Icons.edit_outlined;
  static IconData get delete => _isIOS ? CupertinoIcons.trash : Icons.delete_outline_rounded;
  static IconData get deleteOutline => _isIOS ? CupertinoIcons.trash : Icons.delete_outline;
  static IconData get share => _isIOS ? CupertinoIcons.share : Icons.share_rounded;
  static IconData get clear => _isIOS ? CupertinoIcons.xmark : Icons.clear;
  static IconData get backspace => _isIOS ? CupertinoIcons.delete_left : Icons.backspace_outlined;
  static IconData get notes => _isIOS ? CupertinoIcons.doc_text : Icons.notes;
  static IconData get label => _isIOS ? CupertinoIcons.tag_fill : Icons.label_rounded;
  static IconData get calculate => _isIOS ? CupertinoIcons.equal : Icons.calculate;
  static IconData get calculateOutlined => _isIOS ? CupertinoIcons.equal : Icons.calculate_outlined;
  static IconData get camera => _isIOS ? CupertinoIcons.camera : Icons.camera_alt_rounded;
  static IconData get photoLibrary => _isIOS ? CupertinoIcons.photo_on_rectangle : Icons.photo_library_outlined;
  static IconData get qrCodeScanner => _isIOS ? CupertinoIcons.qrcode_viewfinder : Icons.qr_code_scanner_rounded;

  // ── Date & Time ───────────────────────────────────────────────────────────
  static IconData get calendar => _isIOS ? CupertinoIcons.calendar : Icons.calendar_today_rounded;
  static IconData get calendarOutlined => _isIOS ? CupertinoIcons.calendar : Icons.calendar_today_outlined;
  static IconData get calendarMonth => _isIOS ? CupertinoIcons.calendar : Icons.calendar_month_rounded;
  static IconData get dateRange => _isIOS ? CupertinoIcons.calendar : Icons.date_range_rounded;
  static IconData get editCalendar => _isIOS ? CupertinoIcons.calendar_today : Icons.edit_calendar_outlined;
  static IconData get eventAvailable => _isIOS ? CupertinoIcons.checkmark_seal : Icons.event_available_rounded;
  static IconData get accessTime => _isIOS ? CupertinoIcons.clock : Icons.access_time_rounded;
  static IconData get alarm => _isIOS ? CupertinoIcons.alarm : Icons.alarm;
  static IconData get schedule => _isIOS ? CupertinoIcons.clock : Icons.schedule_outlined;
  static IconData get timerOff => _isIOS ? CupertinoIcons.timer : Icons.timer_off_rounded;
  static IconData get hourglass => _isIOS ? CupertinoIcons.hourglass : Icons.hourglass_bottom_rounded;

  // ── Visibility & Security ──────────────────────────────────────────────────
  static IconData get visibility => _isIOS ? CupertinoIcons.eye : Icons.visibility_rounded;
  static IconData get visibilityOff => _isIOS ? CupertinoIcons.eye_slash : Icons.visibility_off_rounded;
  static IconData get lock => _isIOS ? CupertinoIcons.lock_fill : Icons.lock_rounded;
  static IconData get lockOutline => _isIOS ? CupertinoIcons.lock : Icons.lock_outline_rounded;
  static IconData get verified => _isIOS ? CupertinoIcons.checkmark_seal_fill : Icons.verified_user_rounded;
  static IconData get security => _isIOS ? CupertinoIcons.shield_fill : Icons.security_rounded;
  static IconData get shield => _isIOS ? CupertinoIcons.shield : Icons.shield_rounded;

  // ── Notifications & AI ─────────────────────────────────────────────────────
  static IconData get notifications => _isIOS ? CupertinoIcons.bell : Icons.notifications_outlined;
  static IconData get notificationsActive => _isIOS ? CupertinoIcons.bell_fill : Icons.notifications_active_outlined;
  static IconData get notificationImportant => _isIOS ? CupertinoIcons.bell_fill : Icons.notification_important_rounded;
  static IconData get mic => _isIOS ? CupertinoIcons.mic_fill : Icons.mic_rounded;
  static IconData get micNone => _isIOS ? CupertinoIcons.mic : Icons.mic_none_rounded;
  static IconData get stop => _isIOS ? CupertinoIcons.stop_fill : Icons.stop_rounded;
  static IconData get record => _isIOS ? CupertinoIcons.mic_circle : Icons.record_voice_over_outlined;

  // ── Charts & Analytics (No Cupertino equivalent, keep Material) ────────────
  static IconData get barChart => Icons.bar_chart_rounded;
  static IconData get pieChart => Icons.pie_chart_rounded;
  static IconData get analytics => Icons.analytics_rounded;
  static IconData get insights => Icons.insights_rounded;
  static IconData get autoGraph => Icons.auto_graph_rounded;
  static IconData get autoFix => Icons.auto_fix_high_rounded;
  static IconData get autoAwesome => Icons.auto_awesome_rounded;
  static IconData get trackChanges => Icons.track_changes_rounded;
  static IconData get leakAdd => Icons.leak_add_rounded;

  // ── Premium & Gamification ─────────────────────────────────────────────────
  static IconData get premium => _isIOS ? CupertinoIcons.star_circle_fill : Icons.workspace_premium_rounded;
  static IconData get premiumOutlined => _isIOS ? CupertinoIcons.star_circle : Icons.workspace_premium_outlined;
  static IconData get star => _isIOS ? CupertinoIcons.star_fill : Icons.star_rounded;
  static IconData get stars => _isIOS ? CupertinoIcons.sparkles : Icons.stars_rounded;
  static IconData get celebration => _isIOS ? CupertinoIcons.sparkles : Icons.celebration_rounded;
  static IconData get emojiEvents => _isIOS ? CupertinoIcons.rosette : Icons.emoji_events_rounded;
  static IconData get flash => _isIOS ? CupertinoIcons.bolt_fill : Icons.flash_on_rounded;
  static IconData get bolt => _isIOS ? CupertinoIcons.bolt : Icons.bolt_rounded;
  static IconData get upgrade => _isIOS ? CupertinoIcons.arrow_up_circle_fill : Icons.upgrade;
  static IconData get favorite => _isIOS ? CupertinoIcons.heart_fill : Icons.favorite_rounded;

  // ── Categories & Misc ──────────────────────────────────────────────────────
  static IconData get category => _isIOS ? CupertinoIcons.square_grid_2x2_fill : Icons.category_rounded;
  static IconData get categoryOutlined => _isIOS ? CupertinoIcons.square_grid_2x2 : Icons.category_outlined;
  static IconData get gridView => _isIOS ? CupertinoIcons.grid : Icons.grid_view_rounded;
  static IconData get home => _isIOS ? CupertinoIcons.house_fill : Icons.home_rounded;
  static IconData get school => _isIOS ? CupertinoIcons.book_fill : Icons.school_rounded;
  static IconData get restaurant => _isIOS ? CupertinoIcons.cart_fill : Icons.restaurant_rounded;
  static IconData get shopping => _isIOS ? CupertinoIcons.bag_fill : Icons.shopping_bag_rounded;
  static IconData get shoppingCart => _isIOS ? CupertinoIcons.cart : Icons.shopping_cart_outlined;
  static IconData get fitness => _isIOS ? CupertinoIcons.sportscourt : Icons.fitness_center_rounded;
  static IconData get hospital => _isIOS ? CupertinoIcons.plus_circle : Icons.local_hospital_rounded;
  static IconData get grocery => _isIOS ? CupertinoIcons.cart_fill : Icons.local_grocery_store_rounded;
  static IconData get directionsCar => _isIOS ? CupertinoIcons.car_fill : Icons.directions_car_rounded;
  static IconData get flag => _isIOS ? CupertinoIcons.flag_fill : Icons.flag_rounded;
  static IconData get confirmationNumber => _isIOS ? CupertinoIcons.ticket_fill : Icons.confirmation_number_rounded;
  static IconData get business => _isIOS ? CupertinoIcons.briefcase : Icons.business_center_outlined;
  static IconData get people => _isIOS ? CupertinoIcons.person_2_fill : Icons.people_alt_rounded;
  static IconData get helpOutline => _isIOS ? CupertinoIcons.question_circle : Icons.help_outline;
  static IconData get lightbulb => _isIOS ? CupertinoIcons.lightbulb : Icons.lightbulb_outline_rounded;
  static IconData get wbSunny => _isIOS ? CupertinoIcons.sun_max : Icons.wb_sunny_outlined;
  static IconData get nightsStay => _isIOS ? CupertinoIcons.moon : Icons.nights_stay_outlined;
  static IconData get umbrella => _isIOS ? CupertinoIcons.cloud_rain : Icons.umbrella_outlined;
  static IconData get handshake => _isIOS ? CupertinoIcons.hand_raised : Icons.handshake_outlined;
  static IconData get taskAlt => _isIOS ? CupertinoIcons.checkmark_seal_fill : Icons.task_alt_rounded;
  static IconData get playCircle => _isIOS ? CupertinoIcons.play_circle : Icons.play_circle_outline_rounded;
  static IconData get videoLibrary => _isIOS ? CupertinoIcons.film : Icons.video_library_rounded;
  static IconData get devices => _isIOS ? CupertinoIcons.device_phone_portrait : Icons.devices_rounded;
  static IconData get radioChecked => _isIOS ? CupertinoIcons.checkmark_circle_fill : Icons.radio_button_checked_rounded;
  static IconData get radioUnchecked => _isIOS ? CupertinoIcons.circle : Icons.radio_button_unchecked_rounded;
  static IconData get cardGiftcard => _isIOS ? CupertinoIcons.gift : Icons.card_giftcard_rounded;
  static IconData get adjust => _isIOS ? CupertinoIcons.circle_filled : Icons.adjust_rounded;
  static IconData get download => _isIOS ? CupertinoIcons.cloud_download : Icons.file_download_rounded;
  static IconData get flight => _isIOS ? CupertinoIcons.airplane : Icons.flight_takeoff_outlined;
  static IconData get keyboard => _isIOS ? CupertinoIcons.keyboard : Icons.keyboard_alt_outlined;
  static IconData get touchApp => _isIOS ? CupertinoIcons.hand_draw : Icons.touch_app_rounded;
  static IconData get addChart => Icons.add_chart_rounded;
  static IconData get homeWork => _isIOS ? CupertinoIcons.house_fill : Icons.home_work_rounded;
  static IconData get editNote => _isIOS ? CupertinoIcons.pencil : Icons.edit_note_rounded;
  static IconData get localFire => _isIOS ? CupertinoIcons.flame_fill : Icons.local_fire_department_rounded;
}
