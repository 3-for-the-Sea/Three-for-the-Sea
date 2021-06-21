//
//  SignInViewController.swift
//  Three for the Sea
//
//  Created by Theo Vora on 5/24/21.
//  Copyright © 2021 Ocean Blue Project. All rights reserved.
//

import UIKit
import AuthenticationServices

protocol SignInCoordinatorDelegate: AnyObject {
    func didSignIn(with appleIDCredential: ASAuthorizationAppleIDCredential)
}

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: SignInCoordinatorDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var signInButtonStackView: UIStackView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppleIDButton()
    }
    
    func setupAppleIDButton() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.signInButtonStackView.addArrangedSubview(authorizationButton)
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension SignInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Show the Tab Bar Controller
            delegate?.didSignIn(with: appleIDCredential)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
//            showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
            
        //            case let passwordCredential as ASPasswordCredential:
        //
        //                // Sign in using an existing iCloud Keychain credential.
        //                let username = passwordCredential.user
        //                let password = passwordCredential.password
        //
        //                // For the purpose of this demo app, show the password credential as an alert.
        //                DispatchQueue.main.async {
        //                    self.showPasswordCredentialAlert(username: username, password: password)
        //                }
        
        default:
            break
        }
    }
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
