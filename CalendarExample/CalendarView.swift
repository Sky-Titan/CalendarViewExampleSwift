//
//  CalendarView.swift
//  CalendarExample
//
//  Created by 박준현 on 2022/06/26.
//

import UIKit

class CalendarCellBaseView: UICollectionViewCell {
    
    private var cellView: CalendarCellView?
    
    func setViewModel(_ viewModel: CalendarCellViewModel) {
        if let cellView = cellView {
            cellView.setViewModel(viewModel: viewModel)
        } else {
            let cellView = CalendarCellView()
            contentView.addSubview(cellView)
            cellView.bindToSuperView()
            cellView.setViewModel(viewModel: viewModel)
        }
    }
}

class CalendarSection {
    
    var cellViewModels: [CalendarCellViewModel] = []
    let date: Date
    
    init(date: Date) {
        self.date = date
        
        let currentDay = Calendar.current.component(.day, from: date)
        let firstDayDate = Calendar.current.date(byAdding: .day, value: 1 - currentDay, to: date)!
        
        let indexOfFirstDay = Calendar.current.component(.weekday, from: firstDayDate) - 1
        
        for index in 0 ..< 42 {
            let subtract = index - indexOfFirstDay
            let cellDate = Calendar.current.date(byAdding: .day, value: subtract, to: firstDayDate)!
            cellViewModels.append(CalendarCellViewModel(date: cellDate))
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
    
    private var sections: [CalendarSection] = []
    var cellClickBlock: ((Date) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        loadNib()
        
        innerView.layer.cornerRadius = 8
        self.isHidden = true
        self.alpha = 0
        monthLabel.text = Calendar.current.monthSymbols[Calendar.current.component(.month, from: Date()) - 1]
        
        makeSection()
        collectionView.register(CalendarCellBaseView.self, forCellWithReuseIdentifier: "CalendarCellBaseView")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    private func makeSection() {
        let section = CalendarSection(date: Date())
        sections.append(section)
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
extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = 250 / 6
        let width: CGFloat = (UIScreen.main.bounds.width - 100) / 7
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard sections.count > section else { return 0 }
        return sections[section].cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = sections[indexPath.section].cellViewModels[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCellBaseView", for: indexPath) as? CalendarCellBaseView else {
            let cell = CalendarCellBaseView()
            cell.setViewModel(viewModel)
            return cell
        }
        
        cell.setViewModel(viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = sections[indexPath.section].cellViewModels[indexPath.row]
        cellClickBlock?(viewModel.date)
    }
    
}
