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
    func configure(with viewModel: CellViewModel, delegate: CellDelegate?)
}

extension ConfigurableCell {
    func configure(with viewModel: CellViewModel) {
        configure(with: viewModel, delegate: nil)
    }
    
    func configure(with viewModel: CellViewModel, delegate: CellDelegate?) {
        fatalError()
    }
}

protocol CellDelegate {}

extension ConfigurableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol CellViewModel {
    var associatedCell: ConfigurableCell.Type { get }
}
