import Foundation
import Apollo

final class NetworkManager {
    
    static let instance = NetworkManager()
    
    private init() {}
    
    private(set) lazy var apolloURL = ApolloClient(url: URL(string: AppConstants.apolloEndpointURL)!)
    
    @MainActor
    func getContinentDetails(code: String) async throws -> [SearchCountryDetailsByContinentQuery.Data.Country] {
        return await withCheckedContinuation({ continuation in
            apolloURL.fetch(query: SearchCountryDetailsByContinentQuery(code: code)) { response in
                switch response {
                case .success(let continentData):
                    continuation.resume(returning: continentData.data?.countries ?? [])
                case .failure(let error):
                    continuation.resume(throwing: error as! Never)
                }
            }
        })
    }
    
    @MainActor
    func getCountryAndCode() async throws -> [ContinentListQuery.Data.Continent] {
        return await withCheckedContinuation({ continuation in
            apolloURL.fetch(query: ContinentListQuery()) { response in
                switch response {
                case .success(let countryList):
                    continuation.resume(returning: countryList.data?.continents ?? [])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        })
    }

}


