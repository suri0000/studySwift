//
//  BookShelf++Bundle.swift
//  BookShelf
//
//  Created by 예슬 on 5/8/24.
//

import Foundation

extension Bundle {
    
    // 생성한 .plist 파일 경로 불러오기
    var API_KEY: String {
        guard let file = self.path(forResource: "Secrets", ofType: "plist") else { return "" }
        
        // .plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["API_KEY"] as? String else {
            fatalError("API_KEY error")
        }
        return key
    }
}
