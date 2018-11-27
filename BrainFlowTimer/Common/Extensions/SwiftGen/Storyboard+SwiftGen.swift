// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: nil)
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func performSegue<S: StoryboardSegueType>(segue: S, sender: AnyObject? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

// swiftlint:disable file_length
// swiftlint:disable type_body_length

struct StoryboardScene {
  enum Auth: String, StoryboardSceneType {
    static let storyboardName = "Auth"

    case loginScene = "Login"
    static func instantiateLogin() -> LoginViewController {
      guard let vc = StoryboardScene.Auth.loginScene.viewController() as? LoginViewController
      else {
        fatalError("ViewController 'Login' is not of the expected class LoginViewController.")
      }
      return vc
    }
  }
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    case mainMenuViewControllerScene = "MainMenuViewController"
    static func instantiateMainMenuViewController() -> MainMenuViewController {
      guard let vc = StoryboardScene.Main.mainMenuViewControllerScene.viewController() as? MainMenuViewController
      else {
        fatalError("ViewController 'MainMenuViewController' is not of the expected class MainMenuViewController.")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}
