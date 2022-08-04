import SwiftUI

struct ContinentListView: View {
    @StateObject private var viewModel = ContinentListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.countryList, id: \.code) { countryList in
                NavigationLink(destination: ContinentDetailsView(continentName: countryList.code)) {
                    HStack {
                        Text(countryList.name)
                            .bold()
                        Spacer()
                        Text(countryList.code)
                    }
                }
            }
            .navigationTitle(AppConstants.ContinentListViewTitle)
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            Task {
                try await viewModel.getContinentList()
            }
        }
    }
}
