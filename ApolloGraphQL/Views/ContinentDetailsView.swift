import SwiftUI

struct ContinentDetailsView: View {
    var continentName: String
    @StateObject private var viewModel = CountryContinentDataViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.continentData, id: \.code) { continentData in
                Row(continentData: continentData)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(AppConstants.ContinentDetailsViewTitle)
        }
        .task {
            Task {
                try await viewModel.getContinentData(ByCountryCode: continentName)
            }
        }
    }
}



struct Row: View {
    let continentData: ContinentData
    var body: some View {
        HStack {
            Text(continentData.emoji)
                .font(.system(size: AppFontConstants.SystemFontSize))
            Text(continentData.name)
            Spacer()
            if let currency = continentData.currency {
                Text(currency)
            }
        }
    }
}
