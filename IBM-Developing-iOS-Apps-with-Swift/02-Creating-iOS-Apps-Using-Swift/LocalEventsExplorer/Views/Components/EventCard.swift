import SwiftUI

struct EventCard: View {
    
    let event: Event
    let isSaved: Bool
    let onSaveTapped: () -> Void
    
    @ScaledMetric(relativeTo: .body)
    private var cardSpacing: CGFloat = 12
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: cardSpacing
        ) {
            VStack(
                alignment: .leading,
                spacing: 6
            ) {
                Text(event.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Text(event.venueName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                
                Text(event.eventDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(
                "\(event.priceMin.formatted(.currency(code: "USD"))) – \(event.priceMax.formatted(.currency(code: "USD")))"
            )
            .font(.subheadline)
            .fontWeight(.semibold)
            .contentTransition(.numericText())
            
            Button {
                onSaveTapped()
            } label: {
                HStack {
                    Image(
                        systemName: isSaved
                        ? "heart.fill"
                        : "heart"
                    )
                    
                    Text(
                        isSaved
                        ? "Saved"
                        : "Save"
                    )
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(
                isSaved
                ? Color.green
                : Color.blue
            )
            .padding()
            .background(.regularMaterial)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 20
                )
            )
        }
    }
}
