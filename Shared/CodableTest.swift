//
//  CodableTest.swift
//  Test-SwiftUi
//
//  Created by HotariTobu on 2022/02/20.
//

import SwiftUI

struct CodableTest: View {
    @ObservedObject var model = CodableTest_Model(name: "Tom", age: 35)
    
    @State private var data: Data?
    
    var body: some View {
        Form {
            TextField("Name", text: $model.name, prompt: Text("pro"))
            TextField("Age", value: $model.age, format: .number, prompt: Text("pro"))
            DatePicker("Date", selection: $model.date)
            Button("Store") {
                do {
                    let encoder = JSONEncoder()
                    data = try encoder.encode(model)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            Button("Restore") {
                do {
                    guard let data = data else {
                        throw NSError()
                    }
                    
                    let decoder = JSONDecoder()
                    let oldModel = try decoder.decode(CodableTest_Model.self, from: data)
                    model.reset(oldModel)
                }
                catch {
                    //print(error.localizedDescription)
                }
            }
            Button("+") {
                model.age += 1
            }
            Button("-") {
                model.age -= 1
            }
        }
    }
}

class CodableTest_Model: ObservableObject, Codable {
    @Published var name: String
    @Published var age: Int
    @Published var date: Date
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        self.date = .now
    }
    
    func reset(_ other: CodableTest_Model) {
        self.name = other.name
        self.age = other.age
        self.date = other.date
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        date = try container.decode(Date.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(date, forKey: .date)
    }
}

struct CodableTest_Previews: PreviewProvider {
    static var previews: some View {
        CodableTest()
    }
}
