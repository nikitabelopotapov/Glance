//
//  ProfilerModel.swift
//  Glance
//
//  Created by Nikita Belopotapov on 11.05.2021.
//

import Foundation

typealias Record = ProfilerModel.Record
typealias Section = ProfilerModel.Section

struct ProfilerModel {
    let sections: [Section]

	struct Section {
		let title: String
		let records: [Record]
	}
    
    struct Record {
        let title: String
        let value: String
    }
}
