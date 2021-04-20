//
//  ViewController.swift
//  EmbedSafariViewController
//
//  Created by Oldkay Chang on 2021/4/13.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var embedSwitch: UISwitch!
    @IBOutlet weak var tipLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func clickToOpenSafariViewController(_ sender: UIButton) {
        guard let url = URL(string: urlTextField.text ?? "") else {
            tipLabel.text = "網址有誤，請重新輸入"
            return
        }

        tipLabel.text = ""

        if embedSwitch.isOn {
            // 使用自訂Style
            displayEmbedSafari(url: url,
                               safariStyle: SafariVCStyle(preferredBarTintColor: .black,
                                                          preferredControlTintColor: .systemPink,
                                                          dismissButtonStyle: .close))

            // 使用預設Style
//            displayEmbedSafari(url: url)
        } else {
            // 使用自訂顏色
            displaySimpleSafari(url: url, barTintColor: .black, controlTintColor: .systemPink, buttonStyle: .close)

            // 使用預設顏色
//            displaySimpleSafari(url: url)
        }
    }
}

/*
 extension到UIViewController
 方面未來在其他Viewcontroller也可以呼叫使用
 */
extension UIViewController {
    /// 顯示簡易SafariViewController
    func displaySimpleSafari(url: URL, barTintColor: UIColor = .white, controlTintColor: UIColor = .black, buttonStyle: SFSafariViewController.DismissButtonStyle = .done) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredBarTintColor = barTintColor
        safariViewController.preferredControlTintColor = controlTintColor
        safariViewController.dismissButtonStyle = buttonStyle
        present(safariViewController, animated: true, completion: nil)
    }

    /// 顯示EmbedSafariViewController
    func displayEmbedSafari(url: URL, safariStyle: SafariVCStyle = .default) {
        let viewController = EmbedSafariViewController(url: url, style: safariStyle)
        // 顯示整頁
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: nil)
    }
}

