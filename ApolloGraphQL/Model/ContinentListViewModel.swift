import Foundation

class ContinentListViewModel: ObservableObject {
    @Published var countryList = [ContinentListQuery.Data.Continent]()
    
    func getContinentList() async throws {
        self.countryList = try await NetworkManager.instance.getCountryAndCode()
    }
}
