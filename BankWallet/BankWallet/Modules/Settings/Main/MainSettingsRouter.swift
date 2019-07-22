import UIKit

class MainSettingsRouter {
    weak var viewController: UIViewController?
}

extension MainSettingsRouter: IMainSettingsRouter {

    func showSecuritySettings() {
        viewController?.navigationController?.pushViewController(SecuritySettingsRouter.module(), animated: true)
    }

    func showManageCoins() {
        viewController?.present(ManageWalletsRouter.module(), animated: true)
    }

    func showBaseCurrencySettings() {
        viewController?.navigationController?.pushViewController(BaseCurrencySettingsRouter.module(), animated: true)
    }

    func showLanguageSettings() {
        viewController?.navigationController?.pushViewController(LanguageSettingsRouter.module(), animated: true)
    }

    func showAbout() {
        viewController?.navigationController?.pushViewController(AboutSettingsRouter.module(), animated: true)
    }

    func showShare(text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: [])
        viewController?.present(activityViewController, animated: true, completion: nil)
    }

    func openAppLink() {
        if let url = URL(string: "http://horizontalsystems.io/") {
            UIApplication.shared.open(url)
        }
    }

    func reloadAppInterface() {
        UIApplication.shared.keyWindow?.set(newRootController: MainRouter.module(selectedTab: .settings))
    }

}

extension MainSettingsRouter {

    static func module() -> UIViewController {
        let router = MainSettingsRouter()
        let interactor = MainSettingsInteractor(localStorage: App.shared.localStorage, backupManager: App.shared.backupManager, languageManager: App.shared.languageManager, systemInfoManager: App.shared.systemInfoManager, currencyManager: App.shared.currencyManager, appConfigProvider: App.shared.appConfigProvider)
        let presenter = MainSettingsPresenter(router: router, interactor: interactor)
        let view = MainSettingsViewController(delegate: presenter)

        interactor.delegate = presenter
        presenter.view = view
        router.viewController = view

        return view
    }

}
