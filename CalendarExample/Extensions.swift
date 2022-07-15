//
//  Extensions.swift
//  CalendarExample
//
//  Created by 박준현 on 2022/07/15.
//

import UIKit

extension UIView {
    func bindToSuperView() {
        if let superview = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: superview.topAnchor),
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ])
        }
    }
}
