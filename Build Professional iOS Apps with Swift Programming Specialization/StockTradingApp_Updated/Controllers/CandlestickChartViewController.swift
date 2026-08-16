//
//  CandlestickChartViewController.swift
//  StockTradingApp_Updated
//
//  Created by Valentyn Verovkin on 24.03.2026.
//

import UIKit
import DGCharts

final class CandlestickChartViewController: UIViewController {

    @IBOutlet weak var chartView: CandleStickChartView!

    var stock: Stock?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = stock?.name ?? "Chart"
        configureChart()
        setChartData()
    }

    private func configureChart() {
        view.backgroundColor = .black
        chartView.backgroundColor = .black

        chartView.chartDescription.enabled = false
        chartView.rightAxis.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.legend.enabled = false
        chartView.animate(xAxisDuration: 1.0)

        chartView.leftAxis.labelTextColor = .lightGray
        chartView.xAxis.labelTextColor = .lightGray

        chartView.leftAxis.gridColor = UIColor(white: 0.25, alpha: 1.0)
        chartView.xAxis.gridColor = UIColor(white: 0.25, alpha: 1.0)

        chartView.leftAxis.axisLineColor = .darkGray
        chartView.xAxis.axisLineColor = .darkGray
        
        
    }

    private func setChartData() {
        guard let stock else { return }

        let lower = Int(stock.lowerLimit) ?? 5
        let upper = Int(stock.upperLimit) ?? 10
        let range = UInt32(Int(stock.upperLimitRange) ?? 8)

        let entries: [CandleChartDataEntry] = (0..<12).map { index in
            let base = Double(lower + upper) / 2.0 + Double(arc4random_uniform(range))
            let high = base + Double.random(in: 1...5)
            let low = base - Double.random(in: 1...5)
            let open = base + Double.random(in: -2...2)
            let close = base + Double.random(in: -2...2)

            return CandleChartDataEntry(
                x: Double(index),
                shadowH: high,
                shadowL: low,
                open: open,
                close: close
            )
        }

        let dataSet = CandleChartDataSet(entries: entries, label: stock.name)
        dataSet.decreasingColor = .systemRed
        dataSet.decreasingFilled = true
        dataSet.increasingColor = .systemGreen
        dataSet.increasingFilled = true
        dataSet.neutralColor = .lightGray
        dataSet.shadowColorSameAsCandle = true
        dataSet.shadowWidth = 1.0
        dataSet.drawValuesEnabled = true
        dataSet.valueTextColor = .lightGray
        dataSet.valueFont = .systemFont(ofSize: 10)

        let data = CandleChartData(dataSet: dataSet)
        chartView.data = data
        
        
    }
}
