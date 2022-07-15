//
//  CalendarView.swift
//  CalendarExample
//
//  Created by 박준현 on 2022/06/26.
//

import UIKit

class CalendarCellBaseView: UICollectionViewCell {
    
    private weak var cellView: CalendarCellView?
    
    func setViewModel(_ viewModel: CalendarCellViewModel) {
        if let cellView = cellView {
            cellView.setViewModel(viewModel: viewModel)
        } else {
            let cellView = CalendarCellView()
            contentView.addSubview(cellView)
            cellView.bindToSuperView()
            cellView.setViewModel(viewModel: ViewController)
        }
    }
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
        contentView.bindToSuperView()
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
