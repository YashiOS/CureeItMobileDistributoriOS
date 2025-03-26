//
//  IncomeVC.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import Foundation
import UIKit
import SVProgressHUD

protocol IncomeVCDelegate: AnyObject {
    func fetchIncomeDetails(vendorId: String)
}

class IncomeVC: UIViewController {
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var endDateBtn: UIButton!
    @IBOutlet weak var startDateBtn: UIButton!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var incomeLbl: UILabel!
    var incomeDetails: IncomeDetails? {
        didSet {
            self.incomeLbl.text = "₹"+(incomeDetails?.totalAmount ?? "")
            organizeDataByDate()
        }
    }
    var groupedIncomeData: [(date: String, items: [IncomeDetailsData])] = []
    
    var viewModel: IncomeVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Loading...")
        setupViewModel()
        setupDateButtons()
        setupTableView()
        self.viewModel?.fetchIncomeDetails(vendorId: "SUN-144")
    }
    
    func setupUI() {
        self.incomeLbl.text = "₹"+(incomeDetails?.totalAmount ?? "")
    }
    func setupViewModel() {
        if viewModel == nil {
            self.viewModel = IncomeViewModel(view: self)
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "IncomeTableViewCell", bundle: nil), forCellReuseIdentifier: "IncomeTableViewCell")
        self.tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        self.tableView.separatorStyle = .none
    }
    
    func setupDateButtons() {
        let buttonFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        let titleColor = UIColor(hexString: "#696F8C")
        
        let initialDateFormat = "MM.DD.YYYY"
        startDateBtn.setTitle(initialDateFormat, for: .normal)
        endDateBtn.setTitle(initialDateFormat, for: .normal)
        
        startDateBtn.titleLabel?.font = buttonFont
        endDateBtn.titleLabel?.font = buttonFont
        
        startDateBtn.setTitleColor(titleColor, for: .normal)
        endDateBtn.setTitleColor(titleColor, for: .normal)
        self.startDateView.layer.cornerRadius = 4
        self.startDateView.layer.masksToBounds = true
        self.endDateView.layer.cornerRadius = 4
        self.endDateView.layer.masksToBounds = true
    }
    
    func organizeDataByDate() {
            guard let incomeData = incomeDetails?.data else { return }
            
            let groupedDictionary = Dictionary(grouping: incomeData) { incomeDetail -> String in
                return formatDateString(incomeDetail.deliveredAt ?? "")!
//                return formattedDateString(from: incomeDetail.deliveredAt ?? "")
            }
        groupedIncomeData = groupedDictionary.sorted { $0.key > $1.key }
            .map { (date: $0.key, items: $0.value) }
        }
    
    func formattedDateString(from isoDateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: isoDateString) else { return isoDateString }

        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd MMMM" // Example: "24 March"
            return displayFormatter.string(from: date)
        }
    }
    
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension IncomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedIncomeData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedIncomeData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeTableViewCell", for: indexPath) as? IncomeTableViewCell else { return UITableViewCell() }
               
               let incomeDetail = groupedIncomeData[indexPath.section].items[indexPath.row]
               let viewModel = IncomeDetailsViewModel(incomeData: incomeDetail)
               cell.viewModel = viewModel
               
               return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedIncomeData[section].date
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell else {
            return nil
        }

        let sectionDate = groupedIncomeData[section].date
        let headerModel = HeaderModel(titleString: sectionDate)
        headerCell.viewModel = headerModel

        return headerCell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
}


extension IncomeVC: IncomeViewModelProtocol {
    func getIncomeDetails(response: IncomeDetails) {
        self.incomeDetails = response
        SVProgressHUD.dismiss()
        self.tableView.reloadData()
    }
}
