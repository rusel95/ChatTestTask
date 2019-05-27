// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// test message
  internal static let chatScreenAddRandomIncomingMessageButtonText = L10n.tr("Localizable", "chatScreenAddRandomIncomingMessageButtonText")
  /// Type a messages
  internal static let chatScreenInputTextPlaceholder = L10n.tr("Localizable", "chatScreenInputTextPlaceholder")
  /// Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. \nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
  internal static let chatScreenRandomMessageText = L10n.tr("Localizable", "chatScreenRandomMessageText")
  /// Send
  internal static let chatScreenSendButtonText = L10n.tr("Localizable", "chatScreenSendButtonText")
  /// EXPLORE
  internal static let exploreTabTitle = L10n.tr("Localizable", "exploreTabTitle")
  /// MAP
  internal static let mapTabTitle = L10n.tr("Localizable", "mapTabTitle")
  /// Messages
  internal static let messagesNavitaionTitle = L10n.tr("Localizable", "messagesNavitaionTitle")
  /// MESSAGES
  internal static let messagesTabTitle = L10n.tr("Localizable", "messagesTabTitle")
  /// ORDERS
  internal static let ordersTabTitle = L10n.tr("Localizable", "ordersTabTitle")
  /// PROFILE
  internal static let profileTabTitle = L10n.tr("Localizable", "profileTabTitle")

  internal enum Alert {
    /// Error
    internal static let defaultErrorTile = L10n.tr("Localizable", "alert.default_error_tile")
    /// Information
    internal static let defaultInfoTile = L10n.tr("Localizable", "alert.default_info_tile")
    /// Success
    internal static let defaultSuccessTile = L10n.tr("Localizable", "alert.default_success_tile")
  }

  internal enum Auth {
    internal enum LoginButton {
      /// Login testing again
      internal static let title = L10n.tr("Localizable", "auth.login_button.title")
    }
  }

  internal enum CommonButtons {
    internal enum OkButton {
      /// OK
      internal static let title = L10n.tr("Localizable", "common_buttons.ok_button.title")
    }
    internal enum SaveButton {
      /// Save
      internal static let title = L10n.tr("Localizable", "common_buttons.save_button.title")
    }
  }

  internal enum Error {
    /// Cannot login, please try again later
    internal static let cannotLogin = L10n.tr("Localizable", "error.cannot_login")
    /// Something went wrong, please try again later
    internal static let undefined = L10n.tr("Localizable", "error.undefined")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
