//
//  ViewController.swift
//  TestMEV
//
//  Created by Dima Gubatenko on 27.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import UIKit

final class SearchController: BaseTableViewController {
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    // disable because this table view variable need to be internal for BaseTableViewController use
    //swiftlint:disable:next private_outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet fileprivate weak var searchButton: UIButton!

    fileprivate let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let server = Server()
    fileprivate let database = Database()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSearchBar()
        initBaseTableView()
    }

    @IBAction func searchButtonClicked(_ sender: UIButton) {
        searchBar.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: searchBar.bounds.midX, y: searchBar.bounds.midY)
        activityIndicator.startAnimating()
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        activityIndicator.isHidden = false
        server.searchMovies(title: searchBar.text ?? "") { [weak self] result in
            guard let welf = self else { return }
            welf.activityIndicator.stopAnimating()
            welf.activityIndicator.removeFromSuperview()
            if case .failure(let error) = result {
                showText(error.localizedDescription)
                return
            }
            if case .success(let movies) = result {
                welf.movieModels = movies
                welf.tableView.reloadData()
            }
        }
    }
}

extension SearchController : BaseTableViewDelegate {

    func initBaseTableView() {
        delegate = self
    }

    func clicked(_ model: MovieModel) {
        if let controller = Storyboards.detailInfo as? DetailInfoController {
            database.saveToSearchHistory(movie: model)
            controller.model = model
            navigationController?.pushViewController(controller, animated: true)
        } else {
            log("can't get \(Storyboards.Name.infoScreen) storyboard")
        }
    }

    func errorWithNSError(_ error: NSError) {
        showText(error.localizedDescription)
    }
}

extension SearchController : UISearchBarDelegate {

    func initSearchBar() {
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchButtonClicked(searchButton)
    }
}
