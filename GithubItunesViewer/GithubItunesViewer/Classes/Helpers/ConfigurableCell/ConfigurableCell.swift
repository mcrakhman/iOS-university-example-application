//
//  ConfigurableCell.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

protocol ConfigurableCell {
    static var identifier: String { get }
    
    func configure(with viewModel: CellViewModel)
}

extension ConfigurableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol CellViewModel {
    var associatedCell: ConfigurableCell.Type { get }
}
