//
//  UIButton+action.swift
//  presentation-controller-practice
//
//  Created by jinsei_shima on 2019/06/27.
//  Copyright © 2019 Jinsei Shima. All rights reserved.
//


import UIKit

extension UIButton {
    
    func actionHandler(controlEvents control: UIControl.Event, forAction action: @escaping () -> Void) {
        self.actionHandler(action: action)
        self.addTarget(self, action: #selector(triggerActionHandler), for: control)
    }
    
    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
    
    private func actionHandler(action: (() -> Void)? = nil) {
        
        struct A {
            static var action: (() -> Void)?
        }
        
        if action != nil {
            A.action = action
        } else {
            A.action?()
        }
    }

}
