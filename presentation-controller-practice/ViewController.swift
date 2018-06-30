//
//  ViewController.swift
//  presentation-controller-practice
//
//  Created by Jinsei Shima on 2018/06/29.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit

class MyPresentationController: UIPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {

        return presentedView?.frame ?? .zero
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return frameOfPresentedViewInContainerView.size
    }

    override var shouldPresentInFullscreen: Bool {
        return false
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        guard let containerView = self.containerView else { return }
        tapView.frame = containerView.bounds
    }

    private let tapView: UIVisualEffectView = {
        let view  = UIVisualEffectView()
        view.effect = UIBlurEffect(style: .regular)
        view.alpha = 0
        return view
    }()

    @objc
    private func tapEvent() {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }


    // presentation

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        print("presentation will begin")

//        guard let presentedView = self.presentedView else { return }
//        guard let containerView = self.containerView else { return }

        guard let containerView = self.containerView else { return }

        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapEvent))
        tapView.addGestureRecognizer(gesture)
        containerView.addSubview(tapView)

        guard let transitionCoordinator = presentingViewController.transitionCoordinator else { return }
        transitionCoordinator.animate(
            alongsideTransition: { context in
                self.tapView.alpha = 1.0
        },
            completion: nil
        )
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        print("presentation did end")
    }

    // dismissal

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        print("dismissal will begin")

        guard let transitionCoordinator = presentingViewController.transitionCoordinator else { return }
        transitionCoordinator.animate(
            alongsideTransition: { context in
                self.tapView.alpha = 0
        },
            completion: nil
        )
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        print("dismissal did end")
    }

}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
        button.center = view.center
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        button.backgroundColor = .darkGray
        view.addSubview(button)

        button.addTarget(self, action: #selector(self.tappedButton(_:)), for: .touchUpInside)

    }

    @objc func tappedButton(_ selector: UITapGestureRecognizer) {

        print("tapped button")

        let margin: CGFloat = 20
        let height: CGFloat = 100
        let viewController = UIViewController()
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        viewController.view.frame = CGRect(
            x: margin,
            y: view.frame.height - margin - height,
            width: view.frame.width - margin * 2,
            height: height
        )
        viewController.view.layer.cornerRadius = 8.0
        viewController.view.clipsToBounds = true
        viewController.view.backgroundColor = UIColor.lightGray
        present(viewController, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MyPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
