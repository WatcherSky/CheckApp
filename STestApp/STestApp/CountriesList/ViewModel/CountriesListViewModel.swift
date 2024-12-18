//
//  CountriesListViewModel.swift
//  STestApp
//
//  Created by Владимир on 12.05.2023.
//

import Foundation

class CountriesListViewModel {
    private let networkService: ICountriesListService
    var countriesListModel: Observable<[CountriesListModel]> = Observable([])
    var output: CountriesListFlow?
    init(networkService: ICountriesListService) {
        self.networkService = networkService
    }
    
    // TODO: One model for all data
    var sortedContinents: [String] = []
    var sortedCountries: [[CountriesListModel]] = []
}

extension CountriesListViewModel {

    func viewDidLoad() {
        getCountries {
            self.modifyData()
        } failure: { error in
            print(error)
        }
    }

    private func getCountries(success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        networkService.getCountriesList(completion: { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let countriesList):
                self.countriesListModel.value = countriesList
                success()
            case .failure(let error):
                failure(error)
            }
        })
    }
    
    // Сортируем континенты по алфавиту  и страны по континентам
    func modifyData() {
        self.countriesListModel.bind { [weak self] countries in
            guard let self = self else { return }
            
            let dict = Dictionary(grouping: countries, by: { $0.continents.first! })
            self.sortedContinents = dict.keys.sorted()
            self.sortedCountries = dict.keys.sorted().compactMap {
                dict[$0]
            }
            
            for i in 0..<self.sortedCountries.count {
                self.sortedCountries[i] = self.sortedCountries[i].sorted { n, s in
                    n.name.common < s.name.common
                }
            }
        }
    }

    func selectCountry(cca2Code: String) {
        print("log")
        output?.selectCountry(cca2Code: cca2Code)
    }
}
