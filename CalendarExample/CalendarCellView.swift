//
//  CalendarCellView.swift
//  CalendarExample
//
//  Created by 박준현 on 2022/07/15.
//

import UIKit

class CalendarCellView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var viewModel: CalendarCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadNib() {
        Bundle(for: CalendarCellView.self).loadNibNamed("CalendarCellView", owner: self)
        self.addSubview(contentView)
        contentView.bindToSuperView()
    }
    
    func setViewModel(viewModel: CalendarCellViewModel) {
        self.viewModel = viewModel
        self.dateLabel.text = viewModel.dateString
        
    }
}

class CalendarCellViewModel {
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    let date: Date
    
    init(date: Date) {
        self.date = date
    }
}
