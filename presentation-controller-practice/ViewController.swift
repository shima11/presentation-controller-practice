//
//  ViewController.swift
//  presentation-controller-practice
//
//  Created by Jinsei Shima on 2018/06/29.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.setTitleColor(.darkText, for: .normal)
        button.sizeToFit()
        button.center = view.center
        
        button.actionHandler(controlEvents: .touchUpInside, forAction: {
            
            let viewController = UIViewController()
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.transitioningDelegate = self
            viewController.view.backgroundColor = UIColor.lightGray
            
            let button = UIButton()
            button.actionHandler(controlEvents: .touchUpInside, forAction: {
                self.dismiss(animated: true, completion: nil)
            })
            button.setTitle("Dismiss", for: .normal)
            button.setTitleColor(.darkText, for: .normal)
            button.sizeToFit()
            button.center = viewController.view.center
            viewController.view.addSubview(button)
            
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .overCurrentContext
            
            self.present(navigationController, animated: true, completion: nil)
        })
        
        view.addSubview(button)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
