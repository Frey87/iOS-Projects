//
//  StocksTableViewController.swift
//  StockTradingApp_Updated
//
//  Created by Valentyn Verovkin on 24.03.2026.
//

import UIKit
import Alamofire

final class StocksTableViewController: UITableViewController {

    private var stocks: [Stock] = []

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Market Watch"
        tableView.rowHeight = 110
        tableView.backgroundColor = .black
        tableView.separatorColor = UIColor(white: 0.2, alpha: 1.0)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        stocks = Stock.demoData
        tableView.reloadData()
        showLoadingState()
        fetchStocks()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .black
    }

    private func configureTableView() {
        tableView.rowHeight = 100
        tableView.separatorStyle = .singleLine
    }

    private func showLoadingState() {
        navigationItem.prompt = "Loading market data…"
        tableView.backgroundView = loadingIndicator
        loadingIndicator.startAnimating()
    }

    private func showRemoteStocks(_ stocks: [Stock]) {
        loadingIndicator.stopAnimating()
        navigationItem.prompt = nil
        tableView.backgroundView = nil
        self.stocks = stocks
        tableView.reloadData()
    }

    private func showDemoStocks(after error: Error? = nil) {
        if let error {
            print("Remote market data unavailable; using demo data: \(error)")
        } else {
            print("Remote market data was empty; using demo data.")
        }

        loadingIndicator.stopAnimating()
        navigationItem.prompt = "Demo data — remote source unavailable"
        tableView.backgroundView = nil
        stocks = Stock.demoData
        tableView.reloadData()
    }

    private func fetchStocks() {
        AF.request(AppConstants.endpoint)
            .validate()
            .responseDecodable(of: [Stock].self) { [weak self] response in
                guard let self else { return }

                switch response.result {
                case .success(let stocks):
                    if stocks.isEmpty {
                        self.showDemoStocks()
                    } else {
                        self.showRemoteStocks(stocks)
                    }

                case .failure(let error):
                    self.showDemoStocks(after: error)
                }
            }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as! StockCell
        let stock = stocks[indexPath.row]
        cell.configure(with: stock)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

extension StocksTableViewController: StockCellDelegate {
    func didTapMarketChart(for stock: Stock) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CandlestickChartViewController") as! CandlestickChartViewController
        vc.stock = stock
        navigationController?.pushViewController(vc, animated: true)
    }

    func didTapPortfolio(for stock: Stock) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PieChartViewController") as! PieChartViewController
        vc.stock = stock
        vc.allStocks = stocks
        navigationController?.pushViewController(vc, animated: true)
    }
}
