//
//  ViewController.swift
//  CalendarExample
//
//  Created by 박준현 on 2022/06/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func showButtonClicked(_ sender: Any) {
        let calendarView = CalendarView(frame: self.view.bounds)
        self.view.addSubview(calendarView)
        calendarView.connectToSuperView()
        calendarView.show()
        
    }
}
extension UIView {
    func connectToSuperView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            NSLayoutConstraint.activate([
                superview.topAnchor.constraint(equalTo: self.topAnchor),
                superview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                superview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                superview.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        }
    }
}
