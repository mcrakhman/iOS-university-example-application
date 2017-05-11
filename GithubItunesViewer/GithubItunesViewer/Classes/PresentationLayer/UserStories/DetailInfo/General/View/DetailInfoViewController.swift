//
//  DetailInfoViewController.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController, DetailInfoViewInput, MainModuleOutputProvider, ImageCellDelegate, ViewControllerEmbeddable {
    var output: DetailInfoViewOutput?
    var dataDisplayManager: DetailInfoDataDisplayManager?
    var embedIdentifier: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
    }

    private func setupTableView() {
        let rightCellNib = UINib(nibName: RightDescriptionCell.identifier, bundle: Bundle.main)
        tableView.register(rightCellNib, forCellReuseIdentifier: RightDescriptionCell.identifier)
        
        let leftCellNib = UINib(nibName: LeftDescriptionCell.identifier, bundle: Bundle.main)
        tableView.register(leftCellNib, forCellReuseIdentifier: LeftDescriptionCell.identifier)
        
        tableView.delegate = dataDisplayManager?.delegateForTableView()
        tableView.dataSource = dataDisplayManager?.dataSourceForTableView()
    }
    
    func provideMainModuleOutput() -> MainModuleOutput? {
        return output as? MainModuleOutput
    }
    
    func downloadImage(with configuration: ImageDownloaderConfiguration) {
        output?.didAskToDownloadImage(with: configuration)
    }
    
    func update(with entries: [CellViewModel]) {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
        messageView.isHidden = true
        tableView.isHidden = false
        changeTableData(with: entries)
    }
    
    func changeTableData(with entries: [CellViewModel]) {
        dataDisplayManager?.update(with: entries)
        tableView.reloadData()
    }
    
    func setupInitialState() {
        setupTableView()
        loadingView.isHidden = true
        messageView.isHidden = true
        tableView.isHidden = true
    }
    
    func showLoading() {
        loadingView.isHidden = false
        messageView.isHidden = true
        tableView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func showError(_ description: String) {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
        messageView.isHidden = false
        tableView.isHidden = true
        messageLabel.text = description
    }
    
    func showMessage(_ description: String) {
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
        messageView.isHidden = false
        tableView.isHidden = true
        messageLabel.text = description
    }
    
    @IBAction func repeatButtonTapped(_ sender: Any) {
        output?.didTapRepeatButton()
    }
    
    func didReceiveImageTransition(_ configuration: ImageTransitionConfiguration) {
        output?.didAskToTransition(with: configuration)
    }
    
    func addEmbedIdentifier(_ identifier: String) {
        embedIdentifier = identifier
    }
}

