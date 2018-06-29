//
//  ViewController.swift
//  presentation-controller-practice
//
//  Created by Jinsei Shima on 2018/06/29.
//  Copyright © 2018 Jinsei Shima. All rights reserved.
//

import UIKit


class MyPresentationController: UIPresentationController {
    
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
        button.backgroundColor = .lightGray
        view.addSubview(button)

        button.addTarget(self, action: #selector(self.tappedButton(_:)), for: .touchUpInside)

    }

    @objc func tappedButton(_ selector: UITapGestureRecognizer) {

        print("tapped")

        let viewController = UIViewController()
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        viewController.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        present(viewController, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MyPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
