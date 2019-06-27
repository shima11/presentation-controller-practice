//
//  PresentationController.swift
//  presentation-controller-practice
//
//  Created by jinsei_shima on 2019/06/27.
//  Copyright © 2019 Jinsei Shima. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
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
