//
//  DownloadModel.swift
//  5th_hw_hyungjin
//
//  Created by hyungjin kim on 2023/11/13.
//
import UIKit
import RealmSwift

class DownloadModel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var part: String = ""
}
