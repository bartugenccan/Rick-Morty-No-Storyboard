//
//  RickMortyViewController.swift
//  Rick&MortyNoSB
//
//  Created by Bartu Gençcan on 4.02.2022.
//

import UIKit
import SnapKit

protocol RickMortyOutput {
    func changeLoading(isLoading: Bool)
    func saveData(values: [Result])
}

final class RickMortyViewController: UIViewController {
    
    private let labelTitle: UILabel = UILabel()
    private let tableView: UITableView = UITableView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    private lazy var results: [Result] = []
    
    lazy var viewModel: IRickMortyViewModel = RickMortyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }
    
   private func configure(){
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)
    
        makeTableView()
        makeLabelTitle()
        makeIndicator()
       
       pageDesign()
    }
    
    private func pageDesign(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickMortyTableViewCell.self, forCellReuseIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue)
        
        tableView.rowHeight = 300
        
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            
            self.indicator.color = .blue
            self.indicator.startAnimating()
            
            self.labelTitle.text = "Rick & Morty"
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
        }
        
        
    }

}

extension RickMortyViewController: RickMortyOutput {
    func changeLoading(isLoading: Bool) {
        isLoading ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveData(values: [Result]) {
        results = values
        tableView.reloadData()
    }
}


extension RickMortyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: RickMortyTableViewCell = tableView.dequeueReusableCell(withIdentifier: RickMortyTableViewCell.Identifier.custom.rawValue) as? RickMortyTableViewCell else {
            return UITableViewCell()
        }
        
        cell.saveModel(model: results[indexPath.row])
        
        return cell
    }
}


extension RickMortyViewController {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(labelTitle)
        }
    }
    
    private func makeLabelTitle() {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.right.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
}
