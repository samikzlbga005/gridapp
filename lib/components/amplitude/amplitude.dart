import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/identify.dart';

class AmplitudeConnection {
  static late Amplitude amplitude;

  static Future<void> connect_amplitude() async {
    amplitude = Amplitude.getInstance();
    amplitude.init("f8acbf7c638de69042fbfa42a302cf5e");
  }

  static Future<void> grid_option_selected(String gridVal) async {
    amplitude.logEvent('grid_option_selected',
        eventProperties: {'grid_option': gridVal});
  }

  static Future<void> carousel_option_selected(String CarouselVal) async {
    amplitude.logEvent('carousel_option_selected',
        eventProperties: {'carousel_option': CarouselVal});
  }

  static Future<void> back_icon_tapped() async {
    amplitude.logEvent('back_icon_tapped');
  }

  static Future<void> grid_option_changed(String gridVal) async {
    amplitude.logEvent('grid_option_changed',
        eventProperties: {'grid_option': gridVal});
    print(gridVal);
  }

  static Future<void> carousel_option_changed(String carouselVal) async {
    amplitude.logEvent('carousel_option_changed',
        eventProperties: {'carousel_option': carouselVal});
    print(carouselVal);
  }

  static Future<void> change_image_tapped() async {
    amplitude.logEvent('change_image_tapped');
  }

  static Future<void> image_changed() async {
    amplitude.logEvent('image_changed');
  }

  static Future<void> add_image_tapped() async {
    amplitude.logEvent('add_image_tapped');
  }

  static Future<void> image_added() async {
    amplitude.logEvent('image_added');
    print("image_added");
  }

  static Future<void> image_cropped(
      bool gridOrCarousel, String? grid_option, String? carousel_option) async {
    String grid_or_carousel = gridOrCarousel ? "grid" : "carousel";

    amplitude.logEvent('image_cropped', eventProperties: {
      'scenario': grid_or_carousel,
      'grid_option': grid_option != null ? grid_option : null,
      'carousel_option': carousel_option != null ? carousel_option : null
    });
  }

  static Future<void> save_images_button_tapped(
      bool gridOrCarousel, String? grid_option, String? carousel_option) async {
    String grid_or_carousel = gridOrCarousel ? "grid" : "carousel";

    amplitude.logEvent('save_images_button_tapped', eventProperties: {
      'scenario': grid_or_carousel,
      'grid_option': gridOrCarousel ? grid_option : null,
      'carousel_option': gridOrCarousel ? null : carousel_option
    });
  }

  static Future<void> cropped_images_saved(
      bool gridOrCarousel, String? grid_option, String? carousel_option) async {
    String grid_or_carousel = gridOrCarousel ? "grid" : "carousel";

    amplitude.logEvent('cropped_images_saved', eventProperties: {
      'scenario': grid_or_carousel,
      'grid_option': gridOrCarousel ? grid_option : null,
      'carousel_option': gridOrCarousel ? null : carousel_option
    });
    print("scenario: $grid_or_carousel");
    print("grid_option: $grid_option");
    print("carousel_option: $carousel_option");
  }

  static Future<void> discard_popup_closed() async {
    amplitude.logEvent('discard_popup_closed');
    print("discard_popup_closed");
  }

  static Future<void> cropped_images_discarded(
      bool gridOrCarousel, String? grid_option, String? carousel_option) async {
    String grid_or_carousel = gridOrCarousel ? "grid" : "carousel";

    amplitude.logEvent('cropped_images_discarded', eventProperties: {
      'scenario': grid_or_carousel,
      'grid_option': gridOrCarousel ? grid_option : null,
      'carousel_option': gridOrCarousel ? null : carousel_option
    });
    print("scenario: $grid_or_carousel");
    print("grid_option: $grid_option");
    print("carousel_option: $carousel_option");
  }

  static Future<void> video_ad_popup_closed(
      bool? gridOrCarousel, bool? single_or_all_cover) async {
    late String? val;
    print("gridOrCarousel: $gridOrCarousel");

    if (gridOrCarousel != null) {
      val = gridOrCarousel ? "grid" : "carousel";
    } else {
      val = single_or_all_cover!
          ? "single_highlight_cover"
          : "download_all_covers";
    }
    print(val);
    amplitude
        .logEvent('video_ad_popup_closed', eventProperties: {'scenario': val});
  }

  static Future<void> watch_ad_tapped(
    bool? gridOrCarousel,
    bool? single_or_all_cover,
    String? packName,
    String? packOrder,
    String? coverName,
    String? coverOrder,
    String? carouselSetting,
    String? gridSetting,
  ) async {
    late String? val;
    print("gridOrCarousel: $gridOrCarousel");

    if (gridOrCarousel != null) {
      val = gridOrCarousel ? "grid" : "carousel";
    } else {
      carouselSetting = null;
      gridSetting = null;
      //print(single_or_all_cover);
      val = single_or_all_cover!
          ? "single_highlight_cover"
          : "download_all_covers";
    }
    print(val);
    amplitude.logEvent('watch_ad_tapped', eventProperties: {
      'scenario': val,
      'highlight_cover_pack_name': packName != null ? packName : null,
      'highlight_cover_pack_order': packOrder != null ? packOrder : null,
      'highlight_cover_name': coverName != null ? coverName : null,
      'highlight_cover_order': coverOrder != null ? coverOrder : null,
      'carousel_setting': val != "grid" ? carouselSetting : null,
      'grid_setting': val != "carousel" ? gridSetting : null,
    });
  }

  static Future<void> highlight_cover_pack_opened(
      String packName, String packOrder) async {
    amplitude.logEvent('highlight_cover_pack_opened', eventProperties: {
      'highlight_cover_pack_name': packName,
      'highlight_cover_pack_order': packOrder
    });
  }

  static Future<void> highlight_cover_tapped(String packName, String packOrder,
      String coverName, String coverOrder) async {
    amplitude.logEvent('highlight_cover_tapped', eventProperties: {
      'highlight_cover_pack_name': packName,
      'highlight_cover_pack_order': packOrder,
      'highlight_cover_name': coverName,
      'highlight_cover_order': coverOrder
    });
  }

  static Future<void> download_all_highlight_covers_tapped(
      String packName, String packOrder) async {
    amplitude
        .logEvent('download_all_highlight_covers_tapped', eventProperties: {
      'highlight_cover_pack_name': packName,
      'highlight_cover_pack_order': packOrder,
    });
  }

  static Future<void> highlight_cover_pack_swiped(
      String packName, String packOrder, int pageIndex) async {
    amplitude.logEvent('highlight_cover_pack_swiped', eventProperties: {
      'highlight_cover_pack_name': packName,
      'highlight_cover_pack_order': packOrder,
      'screen': pageIndex,
    });
  }

  //all ads event is inside video_ad_started_completed_failed_skipped funciton
  static Future<void> video_ad_started_completed_failed_skipped(
      bool? gridOrCarousel,
      bool? single_or_all_cover,
      String? packName,
      String? packOrder,
      String? coverName,
      String? coverOrder,
      String? gridSetting,
      String? carouselSetting,
      String eventName) async {
    late String? val;
    print("gridOrCarousel: $gridOrCarousel");

    if (gridOrCarousel != null) {
      val = gridOrCarousel ? "grid" : "carousel";
    } else {
      carouselSetting = null;
      gridSetting = null;
      //print(single_or_all_cover);
      val = single_or_all_cover!
          ? "single_highlight_cover"
          : "download_all_covers";
    }
    amplitude.logEvent(eventName, eventProperties: {
      'scenario': val,
      'highlight_cover_pack_name': packName != null ? packName : null,
      'highlight_cover_pack_order': packOrder != null ? packOrder : null,
      'highlight_cover_name': coverName != null ? coverName : null,
      'highlight_cover_order': coverOrder != null ? coverOrder : null,
      'carousel_setting': val != "grid" ? carouselSetting : null,
      'grid_setting': val != "carousel" ? gridSetting : null,
    });

    print("scenario: $val");
    print("highlight_cover_pack_name: $packName");
    print("highlight_cover_pack_order: $packOrder");
    print("highlight_cover_name: $coverName");
    print("highlight_cover_order: $coverOrder");
    print("carousel_setting: $carouselSetting");
    print("grid_setting: $gridSetting");
  }

  static Future<void> all_highlight_covers_saved(
      String packName, String packOrder) async {
    amplitude.logEvent('all_highlight_covers_saved', eventProperties: {
      'highlight_cover_pack_name': packName,
      'highlight_cover_pack_order': packOrder
    });
    print("highlight_cover_pack_name $packName");
    print("highlight_cover_pack_order $packOrder");
  }

  static Future<void> highlight_cover_saved(String packName, String packOrder,
      String coverName, String coverOrder) async {
    amplitude.logEvent('highlight_cover_saved', eventProperties: {
      'highlight_cover_pack_name': packName,
      'highlight_cover_pack_order': packOrder,
      'highlight_cover_name': coverName,
      'highlight_cover_order': coverOrder
    });
    print("saved after");
    print("highlight_cover_pack_name $packName");
    print("highlight_cover_pack_order $packOrder");
    print("highlight_cover_name $coverName");
    print("highlight_cover_order $coverOrder");
  }

  static Future<void> get_started_tapped() async {
    amplitude.logEvent('get_started_tapped');
  }

  static Future<void> main_screen_opened() async {
    amplitude.logEvent('main_screen_opened');
  }

  static Future<void> highlights_screen_opened() async {
    amplitude.logEvent('highlights_screen_opened');
  }

  static Future<void> settings_screen_opened() async {
    amplitude.logEvent('settings_screen_opened');
  }

  static Future<void> settings_closed() async {
    amplitude.logEvent('settings_closed');
    print("settings_closed");
  }

  static Future<void> rate_us_tapped() async {
    amplitude.logEvent('rate_us_tapped');
    print("rate_us_tapped");
  }

  static Future<void> privacy_policy_tapped() async {
    amplitude.logEvent('privacy_policy_tapped');
    print("privacy_policy_tapped");
  }

  static Future<void> terms_of_services_tapped() async {
    amplitude.logEvent('terms_of_services_tapped');
    print("terms_of_services_tapped");
  }

  static Future<void> contact_us_tapped() async {
    amplitude.logEvent('contact_us_tapped');
    print("contact_us_tapped");
  }

  static Future<void> rate_dialog_closed(bool? grid_carousel_highlights) async {
    late String val;
    if (grid_carousel_highlights != null) {
      val = grid_carousel_highlights ? "grid" : "carousel";
    } else {
      val = "highlight_covers";
    }

    amplitude
        .logEvent('rate_dialog_closed', eventProperties: {'scenario': val});

    print("rate_dialog_closed : $val");
  }

  static Future<void> rate_dialog_triggered(
      bool? grid_carousel_highlights) async {
    late String val;
    if (grid_carousel_highlights != null) {
      val = grid_carousel_highlights ? "grid" : "carousel";
    } else {
      val = "highlight_covers";
    }

    amplitude
        .logEvent('rate_dialog_triggered', eventProperties: {'scenario': val});

    print("rate_dialog_triggered : $val");
  }

  static Future<void> rate_dialog_answered(
      bool? grid_carousel_highlights, bool isAnswer) async {
    late String val;
    late String answer;
    if (grid_carousel_highlights != null) {
      val = grid_carousel_highlights ? "grid" : "carousel";
    } else {
      val = "highlight_covers";
    }
    if (isAnswer) {
      answer = "yes";
    } else {
      answer = "no";
    }
    amplitude.logEvent('rate_dialog_answered',
        eventProperties: {'scenario': val, 'answer': answer});

    print("rate_dialog_answered : $val");
    print("answer : $answer");
  }
}
