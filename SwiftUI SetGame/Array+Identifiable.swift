//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by 김수환 on 2020/07/31.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
