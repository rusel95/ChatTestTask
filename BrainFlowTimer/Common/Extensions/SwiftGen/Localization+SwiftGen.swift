// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum L10n {
  /// Save
  case commonButtonsSaveButtonTitle
  /// OK
  case commonButtonsOkButtonTitle
  /// Login
  case authLoginButtonTitle
  /// Error
  case alertDefaultErrorTile
  /// Success
  case alertDefaultSuccessTile
  /// Information
  case alertDefaultInfoTile
  /// Cannot login, please try again later
  case errorCannotLogin
  /// Something went wrong, please try again later
  case errorUndefined
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .commonButtonsSaveButtonTitle:
        return L10n.tr(key: "common_buttons.save_button.title")
      case .commonButtonsOkButtonTitle:
        return L10n.tr(key: "common_buttons.ok_button.title")
      case .authLoginButtonTitle:
        return L10n.tr(key: "auth.login_button.title")
      case .alertDefaultErrorTile:
        return L10n.tr(key: "alert.default_error_tile")
      case .alertDefaultSuccessTile:
        return L10n.tr(key: "alert.default_success_tile")
      case .alertDefaultInfoTile:
        return L10n.tr(key: "alert.default_info_tile")
      case .errorCannotLogin:
        return L10n.tr(key: "error.cannot_login")
      case .errorUndefined:
        return L10n.tr(key: "error.undefined")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(key: L10n) -> String {
  return key.string
}
