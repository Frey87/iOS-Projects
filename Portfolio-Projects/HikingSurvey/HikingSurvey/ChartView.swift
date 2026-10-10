import SwiftUI
import Charts

struct ChartView: View {
    var responses: [Response]

    init(responses: [Response]) {
        self.responses = responses.sorted { $0.score < $1.score }
    }

    var body: some View {
        Chart(responses) { response in
            SectorMark(
                angle: .value("Type", 1),
                innerRadius: .ratio(0.75)
            )
            .foregroundStyle(by: .value("Sentiment", response.sentiment.rawValue))
        }
        .chartForegroundStyleScale([
            Sentiment.positive.rawValue: Sentiment.positive.sentimentColor,
            Sentiment.negative.rawValue: Sentiment.negative.sentimentColor,
            Sentiment.moderate.rawValue: Sentiment.moderate.sentimentColor
        ])
        .chartLegend(position: .trailing, alignment: .center)
        .frame(height: 200)
        .padding()
    }
}

#Preview {
    ContentView()
}
