//
//  ProfileList.swift
//  Girl
//
//  Created by 小林千浩 on 2023/02/09.
//

import Foundation

class ProfileData {
    
    var data: [String] = Array()
    
    init(fileName: String) {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("file error")
            return
        }
        
        do{
            let aData = try String(contentsOfFile: path, encoding: .utf8)
            self.data = aData.components(separatedBy: "\r\n")
            self.data.removeFirst()
//            self.data.removeLast()
        }catch let error as NSError {
            print("\(error)")
        }
        
    }
    
    func get(index: Int) -> String {
        return self.data[index]
    }
    
    func getAllData() -> [String] {
        return self.data
    }
}
