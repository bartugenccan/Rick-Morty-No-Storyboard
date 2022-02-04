//
//  RickMortyTableViewCell.swift
//  Rick&MortyNoSB
//
//  Created by Bartu Gençcan on 4.02.2022.
//

import UIKit
import SnapKit
import AlamofireImage

class RickMortyTableViewCell: UITableViewCell {
    
    private let customImage: UIImageView = UIImageView()
    private let customTitle: UILabel = UILabel()
    private let customDescription: UILabel = UILabel()
    
    private let randomImage: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
        case custom = "BG13"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(customImage)
        addSubview(customTitle)
        addSubview(customDescription)
        
        customTitle.font = .boldSystemFont(ofSize: 18)
        customDescription.font = .italicSystemFont(ofSize: 10)
        
        makeImage()
        makeTitle()
        makeDescription()
        
    }
    
    private func makeImage(){
        customImage.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.top.equalTo(contentView)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func makeTitle(){
        customTitle.snp.makeConstraints { make in
            make.top.equalTo(customImage.snp.bottom).offset(10)
            make.right.left.equalTo(contentView)
        }
    }
    
    private func makeDescription(){
        customDescription.snp.makeConstraints { make in
            make.top.equalTo(customTitle).offset(5)
            make.right.left.equalTo(customTitle)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model: Result) {
        customTitle.text = model.name
        customDescription.text = model.status
        customImage.af.setImage(withURL: URL(string: model.image ?? "") ?? URL(string: randomImage)!)
    }

}
