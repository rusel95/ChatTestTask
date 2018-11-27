import UIKit

protocol AlertPresentable {
    
    associatedtype AnyAlert: Alert
    
    var alert: AnyAlert { get }
    
    func showAlert(with style: AlertStyle, title: String?, message: String, actionTitle: String?)
    
    /**
     Shows Alert with default Title according to style
     */
    func showDefaultAlert(with style: AlertStyle, message: String)
    
}

extension AlertPresentable {
    
    func showDefaultAlert(with style: AlertStyle, message: String) {
        let title: String
        
        switch style {
        case .error:
            title = tr(key: .alertDefaultErrorTile)
            
        case .success:
            title = tr(key: .alertDefaultSuccessTile)
            
        case .info:
            title = tr(key: .alertDefaultInfoTile)
        }
        
        showAlert(with: style, title: title, message: message, actionTitle: tr(key: .commonButtonsOkButtonTitle))
    }
    
}

extension AlertPresentable where Self: UIViewController {
    
    func showAlert(with style: AlertStyle, title: String? = nil, message: String, actionTitle: String? = nil) {
        alert.show(on: self, with: style, title: title, message: message, actionTitle: actionTitle)
    }
    
}
