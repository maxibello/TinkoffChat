//
//  Funcitons.swift
//  TinkoffChat
//
//  Created by MacBookPro on 10/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation

func modifyDate(byAdding component: Calendar.Component, value: Int, to date: Date) -> Date? {
    let calendar = Calendar.current
    let newDate = calendar.date(byAdding: component, value: value, to: date)
    return newDate
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}
