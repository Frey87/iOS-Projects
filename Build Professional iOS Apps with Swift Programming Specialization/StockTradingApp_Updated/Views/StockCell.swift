import UIKit

protocol StockCellDelegate: AnyObject {
    func didTapMarketChart(for stock: Stock)
    func didTapPortfolio(for stock: Stock)
}

final class StockCell: UITableViewCell {

    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockExchangeLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var percentageWrapperView: UIView!
    @IBOutlet weak var stockPercentageLabel: UILabel!
    @IBOutlet weak var marketChartButton: UIButton!
    @IBOutlet weak var portfolioButton: UIButton!

    weak var delegate: StockCellDelegate?
    private var stock: Stock?

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .black
        contentView.backgroundColor = .black

        stockNameLabel.textColor = .white
        stockNameLabel.font = .boldSystemFont(ofSize: 18)

        stockExchangeLabel.textColor = .lightGray
        stockExchangeLabel.font = .systemFont(ofSize: 14)

        stockPriceLabel.textColor = .white
        stockPriceLabel.font = .boldSystemFont(ofSize: 18)

        stockPercentageLabel.textColor = .white
        stockPercentageLabel.textAlignment = .center
        stockPercentageLabel.font = .boldSystemFont(ofSize: 14)
        stockPercentageLabel.adjustsFontSizeToFitWidth = true
        stockPercentageLabel.minimumScaleFactor = 0.8

        percentageWrapperView.layer.cornerRadius = 6
        percentageWrapperView.clipsToBounds = true

        styleButton(marketChartButton)
        styleButton(portfolioButton)

        selectionStyle = .none
    }

    private func styleButton(_ button: UIButton) {
        button.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
    }

    func configure(with stock: Stock) {
        self.stock = stock

        stockNameLabel.text = stock.name
        stockExchangeLabel.text = stock.stockExchange
        stockPriceLabel.text = stock.price
        stockPercentageLabel.text = stock.percentage

        if stock.percentage.contains("-") {
            percentageWrapperView.backgroundColor = .systemRed
        } else {
            percentageWrapperView.backgroundColor = .systemGreen
        }
    }

    @IBAction func marketChartTapped(_ sender: UIButton) {
        guard let stock else { return }
        delegate?.didTapMarketChart(for: stock)
    }

    @IBAction func portfolioTapped(_ sender: UIButton) {
        guard let stock else { return }
        delegate?.didTapPortfolio(for: stock)
    }
}
