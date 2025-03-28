//
//  FirebaseObserver.swift
//  Raiva
//
//  Created by Jesus Ortega on 28/03/25.
//

import Foundation

protocol FirebaseObserver{
    var path: String {get}
    func startObserving(completion: @escaping ([String: Any]) -> Void)
    func stopObserving()
}
