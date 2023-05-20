//
//  String+Helpers.swift
//  Hilo
//
//  Created by Ярослав on 20.05.2023.
//

extension String {
    func format(_ args: CVarArg...) -> String {
        String(format: self, arguments: args)
    }
}
