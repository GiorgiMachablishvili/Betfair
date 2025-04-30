

import UIKit
import SnapKit
import AuthenticationServices
import Alamofire
import ProgressHUD
import GoogleSignIn

class SignInController: UIViewController {

    private lazy var signInBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .whiteColor
        view.makeRoundCorners(44)
        return view
    }()

    private lazy var signInImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "mainScreenImage")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var saveYourProgressTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Save your progress"
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 24)
        view.textAlignment = .center
        return view
    }()

    private lazy var saveYourProgressLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "To keep your results from getting lost, log in the way that's most convenient for you."
        view.textColor = UIColor.blackColor
        view.font = UIFont.poppinsBold(size: 14)
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()

    private lazy var googleButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.backgroundColor = UIColor.gayBackground.withAlphaComponent(0.05)
        view.makeRoundCorners(24)

        let imageView = UIImageView(image: UIImage(named: "googleLogo"))
        imageView.contentMode = .scaleAspectFit

        view.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 32, height: 32))
        }

        view.addTarget(self, action: #selector(clickAppleButton), for: .touchUpInside)
        return view
    }()

    private lazy var appleButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.backgroundColor = UIColor.gayBackground.withAlphaComponent(0.05)
        view.makeRoundCorners(24)

        let imageView = UIImageView(image: UIImage(named: "appleLogo"))
        imageView.contentMode = .scaleAspectFit

        view.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 32, height: 32))
        }

        view.addTarget(self, action: #selector(clickAppleButton), for: .touchUpInside)
        return view
    }()


    private lazy var closeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Close", for: .normal)
        view.backgroundColor = UIColor.whiteColor
        view.titleLabel?.font = UIFont.poppinsMedium(size: 14)
        view.setTitleColor(UIColor.blackColor, for: .normal)
        view.makeRoundCorners(24)
        view.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blackColor.withAlphaComponent(0.2)

        setup()
        setupConstraint()
    }

    private func setup() {
        view.addSubview(signInBackground)
        view.addSubview(signInImage)
        view.addSubview(saveYourProgressTitle)
        view.addSubview(saveYourProgressLabel)
        view.addSubview(googleButton)
        view.addSubview(appleButton)
        view.addSubview(closeButton)
    }

    private func setupConstraint() {
        signInBackground.snp.remakeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-100 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(430 * Constraint.yCoeff)
        }

        signInImage.snp.remakeConstraints { make in
            make.top.equalTo(signInBackground.snp.top)
            make.leading.equalTo(signInBackground.snp.leading)
            make.trailing.equalTo(signInBackground.snp.trailing)
            make.height.equalTo(212 * Constraint.yCoeff)
        }

        saveYourProgressTitle.snp.remakeConstraints { make in
            make.top.equalTo(signInImage.snp.bottom).offset(20 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
            make.height.equalTo(36 * Constraint.yCoeff)
        }

        saveYourProgressLabel.snp.remakeConstraints { make in
            make.top.equalTo(saveYourProgressTitle.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20 * Constraint.xCoeff)
        }

        googleButton.snp.remakeConstraints { make in
            make.bottom.equalTo(signInBackground.snp.bottom).offset(-20 * Constraint.yCoeff)
            make.leading.equalTo(signInBackground.snp.leading).offset(20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(155 * Constraint.xCoeff)
        }

        appleButton.snp.remakeConstraints { make in
            make.bottom.equalTo(signInBackground.snp.bottom).offset(-20 * Constraint.yCoeff)
            make.trailing.equalTo(signInBackground.snp.trailing).offset(-20 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
            make.width.equalTo(155 * Constraint.xCoeff)
        }

        closeButton.snp.remakeConstraints { make in
            make.top.equalTo(signInBackground.snp.bottom).offset(8 * Constraint.yCoeff)
            make.leading.trailing.equalToSuperview().inset(16 * Constraint.xCoeff)
            make.height.equalTo(60 * Constraint.yCoeff)
        }
    }

    @objc private func clickCloseButton() {
        let mainViewController = Onboarding()
        navigationController?.pushViewController(mainViewController, animated: true)
    }

    @objc private func clickGoogleButton() {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            print("Google Sign-In Client ID not found")
            return
        }

        let config = GIDConfiguration(clientID: userId)
        GIDSignIn.sharedInstance.configuration = config

        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                print("Google Sign-In failed: \(error.localizedDescription)")
                return
            }

            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Google Sign-In: No user or token found")
                return
            }

            print("Google User: \(user.profile?.name ?? "No Name")")
            print("Google Email: \(user.profile?.email ?? "No Email")")
            print("Google ID Token: \(idToken)")

            // Store token in UserDefaults (Optional)
            UserDefaults.standard.setValue(idToken, forKey: "GoogleIDToken")

            // Call createUser() with the Google token
            self.createUser(withGoogleToken: idToken)
        }
    }

    private func createUser(withGoogleToken googleToken: String? = nil) {
        NetworkManager.shared.showProgressHud(true, animated: true)

        let pushToken = UserDefaults.standard.string(forKey: "PushToken") ?? ""
        let appleToken = UserDefaults.standard.string(forKey: "AccountCredential") ?? ""
        let googleToken = googleToken ?? ""

        // Prepare parameters
        let parameters: [String: Any] = [
            "push_token": pushToken,
            "apple_token": appleToken,
            "google_token": googleToken
        ].filter { !$0.value.isEmpty } // Remove empty values

        // Make the network request
        NetworkManager.shared.post(
            url: String.userCreate(),
            parameters: parameters,
            headers: nil
        ) { [weak self] (result: Result<UserCreate>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                NetworkManager.shared.showProgressHud(false, animated: false)
                UserDefaults.standard.setValue(false, forKey: "isGuestUser")
            }
            print("\(parameters)")
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    print("User created: \(userInfo)")
                    UserDefaults.standard.setValue(userInfo.id, forKey: "userId")
                    print("Received User ID: \(userInfo.id)")

                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        let mainViewController = Onboarding()
                        let navigationController = UINavigationController(rootViewController: mainViewController)
                        sceneDelegate.changeRootViewController(navigationController)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", description: error.localizedDescription)
                }
                print("Error: \(error)")
            }
        }
    }


    @objc private func clickAppleButton() {
        // Simulating tokens for testing
        let mockPushToken = "mockPushToken"
        let mockAppleToken = "mockAppleToken"

        // Store mock tokens in UserDefaults
        UserDefaults.standard.setValue(mockPushToken, forKey: "PushToken")
        UserDefaults.standard.setValue(mockAppleToken, forKey: "AccountCredential")

        // Call createUser to simulate user creation
        createUser()

        //        let authorizationProvider = ASAuthorizationAppleIDProvider()
        //        let request = authorizationProvider.createRequest()
        //        request.requestedScopes = [.email, .fullName]
        //
        //        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        //        authorizationController.delegate = self
        //        authorizationController.performRequests()

    }

    private func createUser() {
        NetworkManager.shared.showProgressHud(true, animated: true)

        let pushToken = UserDefaults.standard.string(forKey: "PushToken") ?? ""
        let appleToken = UserDefaults.standard.string(forKey: "AccountCredential") ?? ""

        // Prepare parameters
        let parameters: [String: Any] = [
            "push_token": pushToken,
            "apple_token": appleToken,
        ]

        // Make the network request
        NetworkManager.shared.post(
            url: String.userCreate(),
            parameters: parameters,
            headers: nil
        ) { [weak self] (result: Result<UserCreate>) in
            guard let self = self else { return }

            DispatchQueue.main.async {
                NetworkManager.shared.showProgressHud(false, animated: false)
                UserDefaults.standard.setValue(false, forKey: "isGuestUser")
            }
            print("\(parameters)")
            switch result {
            case .success(let userInfo):
                DispatchQueue.main.async {
                    print("User created: \(userInfo)")
                    UserDefaults.standard.setValue(userInfo.id, forKey: "userId")
                    print("Received User ID: \(userInfo.id)")

                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        let mainViewController = Onboarding()
                        let navigationController = UINavigationController(rootViewController: mainViewController)
                        sceneDelegate.changeRootViewController(navigationController)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", description: error.localizedDescription)
                }
                print("Error: \(error)")
            }
        }
    }

    private func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

extension SignInController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        UserDefaults.standard.setValue(credential.user, forKey: "AccountCredential")

        //        createUser()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Authorization failed: \(error.localizedDescription)")
        //        showAlert(title: "Sign In Failed", description: error.localizedDescription)
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

