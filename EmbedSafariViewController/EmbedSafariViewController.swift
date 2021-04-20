//
//  EmbedSafariViewController.swift
//  EmbedSafariViewController
//
//  Created by Oldkay Chang on 2021/4/13.
//

import UIKit
import SafariServices

@available(iOS 11.0, *)
/// Safari樣式
struct SafariVCStyle {
    static let `default`: SafariVCStyle = SafariVCStyle()
    var preferredBarTintColor: UIColor = .black
    var preferredControlTintColor: UIColor = .white
    var dismissButtonStyle: SFSafariViewController.DismissButtonStyle = .close
}

@available(iOS 11.0, *)
class EmbedSafariViewController: UIViewController {

    /// 指定的網址
    private var url: URL!
    /// 自訂Safari樣式
    private var style: SafariVCStyle!

    private var safariViewController: SFSafariViewController?


    /// init
    /// - Parameters:
    ///   - url: 外部傳入的網址
    ///   - style: 外部傳入的樣式
    init(url: URL, style: SafariVCStyle = .default) {
        self.url = url
        self.style = style
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }

    func bindUI() {
        safariViewController = SFSafariViewController(url: url)
        safariViewController?.preferredBarTintColor = style.preferredBarTintColor
        safariViewController?.preferredControlTintColor = style.preferredControlTintColor
        safariViewController?.dismissButtonStyle = style.dismissButtonStyle
        safariViewController?.delegate = self
        embed(safariViewController!, to: view)
    }
}

@available(iOS 11.0, *)
// delegate方法為optional，暫時未實作
extension EmbedSafariViewController: SFSafariViewControllerDelegate {}

extension UIViewController {
    /// 將子畫面加到指定view中
    func embed(_ child: UIViewController, to subView: UIView) {
        addChild(child)
        subView.addSubview(child.view)
        child.view.frame = subView.bounds
        child.didMove(toParent: self)
    }
}
