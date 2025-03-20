//
//  UnsettledTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit

class UnsettledTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "UnsettledDetailedTableViewCell", bundle: nil), forCellReuseIdentifier: "UnsettledDetailedTableViewCell")
    }
}

extension UnsettledTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UnsettledDetailedTableViewCell", for: indexPath) as? UnsettledDetailedTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}
