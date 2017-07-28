//
//  HistoryController.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

final class HistoryController: BaseTableViewController {
    // disable because this table view variable need to be internal for BaseTableViewController use
    //swiftlint:disable:next private_outlet
    @IBOutlet weak var tableView: UITableView!

    fileprivate let dataLayer = DataLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        initBaseTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHistory()
    }
}

extension HistoryController {

    func getHistory() {
        movieModels = dataLayer.getSearchHistory()
        tableView.reloadData()
    }
}

extension HistoryController : BaseTableViewDelegate {

    func initBaseTableView() {
        delegate = self
    }

    func clicked(_ model: MovieModel) {
        if let controller = Storyboards.detailInfo as? DetailInfoController {
            controller.model = model
            navigationController?.pushViewController(controller, animated: true)
        } else {
            log("can't get \(Storyboards.Name.detailInfo) storyboard")
        }
    }

    func errorWithNSError(_ error: NSError) {
        showText(error.localizedDescription)
    }
}
