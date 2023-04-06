//
//  CalendarViewController.swift
//  DiaryCodeBased
//
//  Created by Junhee Yoon on 2022/08/26.
//

import UIKit

import FSCalendar
import RealmSwift

class CalendarViewController: BaseViewController {

    // MARK: - Properties
    
    lazy var calendar: FSCalendar = {
        let cal = FSCalendar()
        cal.delegate = self
        cal.dataSource = self
        cal.backgroundColor = .systemBackground
        return cal
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()
    
    let repository = UserDiaryRepository()
    
    var tasks: Results<UserDiary>! {
        didSet {
            calendar.reloadData()
            print("Tasks Changed")
        }
    }
    
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        view.backgroundColor = .systemGreen
        [calendar].forEach{ view.addSubview($0) }
        showNaviBars(naviTitle: "달력", naviBarTintColor: .systemBackground)
    }
    
    override func setConstraints() {
        calendar.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


// MARK: - Extension: FSCalendarDelegate

extension CalendarViewController: FSCalendarDelegate {
    
}


// MARK: - Extension: FSCalendarDataSource

extension CalendarViewController: FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "새싹"
//    }
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "applelogo")
//    }
    
    // date: yyyyMMdd hh:mm:ss -> dateformatter
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return formatter.string(from: date) == "220907" ? "오프라인 모임" : nil
    }

    // 100 ->
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasks = repository.fetchDate(date: date)
    }
    
}
