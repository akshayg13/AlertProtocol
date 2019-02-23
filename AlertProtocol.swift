import UIKit

protocol AlertProtocol {
    
    /// Show UIAlertController with specified parameters
    ///
    /// - Parameters:
    ///   - title: Title of the Alert
    ///   - message: Message of the Alert
    ///   - showCancel: Should show cancelButton
    ///   - cancelTitle: Title of the cancel action
    ///   - okayTitle: Title of the ok action
    ///   - completion: Closure to handle the okay action
    func showAlert(_ title : String, message : String?, showCancel : Bool, cancelTitle : String?, okayTitle : String?, completion : (()->())?)
    
    /// Show alert to redirect user for the settings page
    ///
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - cancelTitle: Cancel button title
    ///   - okayTitle: Okay button title
    ///   - message: Message to show in the alert body
    func showRedirectAlert(_ title : String, cancelTitle : String?, okayTitle : String?, message : String)

}

// MARK: - UIViewController
extension AlertProtocol where Self : UIViewController {
    
    func showAlert(_ title : String, message : String? = nil, showCancel : Bool, cancelTitle : String? = nil, okayTitle : String? = nil, completion : (()->())?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if showCancel {
            alert.addAction(UIAlertAction(title: cancelTitle ?? StringConstants.cancel.localized, style: .default, handler: nil))
        }
        
        alert.addAction(UIAlertAction(title: okayTitle ?? StringConstants.ok.localized, style: .default, handler: { _ in
            completion?()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showRedirectAlert(_ title : String, cancelTitle : String? = nil, okayTitle : String? = nil, message : String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancelTitle ?? StringConstants.cancel.localized, style: .default, handler: nil))

        alert.addAction(UIAlertAction(title: okayTitle ?? StringConstants.goToSettings.localized, style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                DispatchQueue.main.async{
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
