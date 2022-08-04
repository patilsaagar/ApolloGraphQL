import Foundation

typealias ContinentData = SearchCountryDetailsByContinentQuery.Data.Country

class CountryContinentDataViewModel: ObservableObject {
    @Published var continentData = [ContinentData]()
            
    func getContinentData(ByCountryCode code: String) async throws {
        self.continentData = try await NetworkManager.instance.getContinentDetails(code: code)
    }
}
