//
//  DownloadModel.swift
//  5th_hw_hyungjin
//
//  Created by hyungjin kim on 2023/11/13.
//
import UIKit
import RealmSwift

class DownloadModel: Object {
    @Persisted var title: String = ""
    @Persisted var movieDescription: String = ""
    @Persisted var imageData: Data?
}


