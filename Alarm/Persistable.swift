//
//  Persistable.swift
//  Alarm-ios-swift
//
//  Created by Stefano Brandi on 11/06/21.
//

import Foundation

protocol Persistable{
    var ud: UserDefaults {get}
    var persistKey : String {get}
    func persist()
    func unpersist()
}
