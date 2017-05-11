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
    var container: UIView { get }
    
    func embed(_ viewController: UIViewController)
    func embedAndTransition(from sourceViewController: UIViewController,
                            to destinationViewController: UIViewController)
    func transition(from sourceViewController: UIViewController,
                    to destinationViewController: UIViewController)
    func findEmbeddableChild(with identifier: String) -> UIViewController?
}

extension ViewControllerEmbedding where Self: UIViewController {
    
    func embed(_ viewController: UIViewController) {
        addChildViewController(viewController)
        container.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints(for: viewController)
        viewController.didMove(toParentViewController: self)
    }

    func embedAndTransition(from sourceViewController: UIViewController,
                            to destinationViewController: UIViewController) {
        sourceViewController.beginAppearanceTransition(false, animated: false)
        embed(destinationViewController)
        sourceViewController.endAppearanceTransition()
    }

    func transition(from sourceViewController: UIViewController,
                    to destinationViewController: UIViewController) {
        sourceViewController.beginAppearanceTransition(false, animated: false)
        destinationViewController.beginAppearanceTransition(true, animated: false)

        container.bringSubview(toFront: destinationViewController.view)

        sourceViewController.endAppearanceTransition()
        destinationViewController.endAppearanceTransition()
    }
    
    func findEmbeddableChild(with identifier: String) -> UIViewController? {
        let viewControllers = childViewControllers.flatMap { $0 as? ViewControllerEmbeddable }
        return viewControllers.first(where: { $0.embedIdentifier == identifier }) as? UIViewController
    }
    
    private func setupConstraints(for viewController: UIViewController) {
        viewController.view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
    }
}

