//
//  CalendarView.swift
//  CalendarExample
//
//  Created by 박준현 on 2022/06/26.
//

import UIKit

class CanlendarCellView: UICollectionViewCell {
    
}

class CalendarCellViewModel {
    
}

class CalendarView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func initialize() {
        loadNib()
        
        innerView.layer.cornerRadius = 4
        self.isHidden = true
        self.alpha = 0
    }
    
    private func loadNib() {
        Bundle(for: CalendarView.self).loadNibNamed("CalendarView", owner: self)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    @IBAction func backgroundClicked(_ sender: Any) {
        close()
    }
    
    func show() {
        self.isHidden = false
        UIView.animate(withDuration: 0.15, delay: 0, options: [], animations: { [weak self] in
            self?.alpha = 1
        }, completion: nil)
    }
    
    func close() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [], animations: { [weak self] in
            self?.alpha = 0
        }, completion: { [weak self] _ in
            self?.removeFromSuperview()
        })
    }
}
