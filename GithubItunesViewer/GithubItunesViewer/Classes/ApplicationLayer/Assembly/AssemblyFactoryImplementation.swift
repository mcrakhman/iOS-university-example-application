//
//  AssemblyFactoryImplementation.swift
//  GithubItunesViewer
//
//  Created by m.rakhmanov on 22.01.17.
//  Copyright © 2017 m.rakhmanov. All rights reserved.
//

import Foundation

class AssemblyFactoryImplementation: AssemblyFactory {
    func iTunesAssembly() -> ITunesAssembly {
        return ITunesAssemblyImplementation(assemblyFactory: self)
    }
    
    func githubAssembly() -> GithubAssembly {
        return GithubAssemblyImplementation(assemblyFactory: self)
    }
    
    func mainAssembly() -> MainAssembly {
        return MainAssemblyImplementation(assemblyFactory: self)
    }
    
    func coreAssembly() -> CoreAssembly {
        return CoreAssemblyImplementation()
    }
    
    func serviceAssembly() -> ServiceAssembly {
        return ServiceAssemblyImplementation(assemblyFactory: self)
    }
    
    func helperAssembly() -> HelperAssembly {
        return HelperAssemblyImplementation()
    }
}
