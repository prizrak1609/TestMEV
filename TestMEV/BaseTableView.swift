//
//  BaseTableView.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

protocol BaseTableViewDelegate : class {
    var tableView: UITableView! { get }

    func clicked(_ model: MovieModel)
    func errorWithNSError(_ error: NSError)
}

class BaseTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var movieModels = [MovieModel]() {
        didSet {
            delegate.tableView.reloadData()
        }
    }

    weak var delegate: BaseTableViewDelegate! {
        didSet {
            delegate.tableView.delegate = self
            delegate.tableView.dataSource = self
            delegate.tableView.rowHeight = MovieBaseInfoCell.height
            delegate.tableView.register(UINib(nibName: CellIdentifiers.moviewBaseInfo, bundle: nil), forCellReuseIdentifier: CellIdentifiers.moviewBaseInfo)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModels.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate.clicked(movieModels[indexPath.row])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.moviewBaseInfo) as? MovieBaseInfoCell else { return UITableViewCell() }
        let model = movieModels[indexPath.row]
        cell.model = model
        return cell
    }
}
