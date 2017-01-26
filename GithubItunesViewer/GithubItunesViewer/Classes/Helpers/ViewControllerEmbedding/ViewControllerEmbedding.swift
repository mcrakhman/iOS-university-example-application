//
//  ViewControllerEmbedding.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 21.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerEmbedding {
    var containerView: UIView! { get set }

    func embed(_ viewController: UIViewController)
    func embeddedTransition(to viewController: UIViewController)
    func findEmbeddableChild(with identifier: String) -> UIViewController?
}

extension ViewControllerEmbedding where Self: UIViewController {
    
    func embed(_ viewController: UIViewController) {
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints(for: viewController)
    }
    
    func embeddedTransition(to viewController: UIViewController) {
        viewController.willMove(toParentViewController: self)
        self.beginAppearanceTransition(false, animated: true)
        viewController.beginAppearanceTransition(true, animated: false)
        containerView.bringSubview(toFront: viewController.view)
        viewController.didMove(toParentViewController: self)
        viewController.endAppearanceTransition()
        self.endAppearanceTransition()
    }
    
    func findEmbeddableChild(with identifier: String) -> UIViewController? {
        let viewControllers = childViewControllers.map { $0 as? ViewControllerEmbeddable }.filter { $0 != nil }
        if let embeddableViewControllers = viewControllers as? [ViewControllerEmbeddable], embeddableViewControllers.count > 0 {
            return embeddableViewControllers.filter { $0.embedIdentifier == identifier }.first as? UIViewController
        }
        
        return nil
    }
    
    private func setupConstraints(for viewController: UIViewController) {
        viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    }
}

