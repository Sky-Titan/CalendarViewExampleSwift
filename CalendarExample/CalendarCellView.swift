//
//  CalendarCellView.swift
//  CalendarExample
//
//  Created by 박준현 on 2022/07/15.
//

import UIKit

class CalendarCellView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dimView: UIView!
    
    private var viewModel: CalendarCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
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
        self.label.text = viewModel.dateString
        
        dimView.isHidden = viewModel.isSameMonth
        
        if viewModel.isToday {
            label.textColor = .green
        } else if viewModel.isSunday {
            label.textColor = .red
        } else if viewModel.isSaturDay {
            label.textColor = .blue
        } else {
            label.textColor = .label
        }
    }
}

class CalendarCellViewModel {
    
    var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    var isSameMonth: Bool {
        Calendar.current.component(.month, from: todayDate) == Calendar.current.component(.month, from: date)
    }
    
    var isSunday: Bool {
        Calendar.current.component(.weekday, from: date) == 1
    }
    var isSaturDay: Bool {
        Calendar.current.component(.weekday, from: date) == 7
    }
    
    var dateString: String {
        return Calendar.current.component(.day, from: date).description
    }
    
    let date: Date
    let todayDate: Date = Date()
    
    init(date: Date) {
        self.date = date
    }
}
