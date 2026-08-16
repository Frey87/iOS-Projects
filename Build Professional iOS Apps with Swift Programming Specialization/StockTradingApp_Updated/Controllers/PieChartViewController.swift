//
//  PieChartViewController.swift .swift
//  StockTradingApp_Updated
//
//  Created by Valentyn Verovkin on 24.03.2026.
//

import UIKit
import DGCharts

final class PieChartViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!

    var stock: Stock?
    var allStocks: [Stock] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Portfolio"
        configureChart()
        setChartData()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    private func configureChart() {
        view.backgroundColor = .black
        pieChartView.backgroundColor = .black

        pieChartView.usePercentValuesEnabled = true
        pieChartView.drawHoleEnabled = true
        pieChartView.holeRadiusPercent = 0.5
        pieChartView.transparentCircleRadiusPercent = 0.55
        pieChartView.chartDescription.enabled = false
        pieChartView.entryLabelColor = .white
        pieChartView.entryLabelFont = .systemFont(ofSize: 12, weight: .medium)
        pieChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center

        let centerText = NSAttributedString(
            string: "Your\nInvestments",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraph
            ]
        )
        pieChartView.centerAttributedText = centerText
    }

    private func setChartData() {
        let entries: [PieChartDataEntry] = allStocks.map { stock in
            let value = Double.random(in: 5...25)
            return PieChartDataEntry(value: value, label: stock.name)
        }

        let dataSet = PieChartDataSet(entries: entries, label: "Stock Portfolio")
        dataSet.sliceSpace = 2
        dataSet.colors = ChartColorTemplates.material() +
                         ChartColorTemplates.colorful() +
                         ChartColorTemplates.joyful()

        let data = PieChartData(dataSet: dataSet)

        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1
        formatter.percentSymbol = "%"

        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        data.setValueTextColor(.label)

        pieChartView.data = data
        pieChartView.highlightValues(nil)
    }
}
