import SwiftUI
struct MyGroup {
    var name: String, items: [String]
}

struct Demo: View {
    var groups: [MyGroup] = [
        .init(name: "Animals", items: ["🐕", "🐩", "🐂", "🐄", "🐈", "🦩", "🐿", "🐇"]),
        .init(name: "Vehicles", items: ["🚕", "🚗", "🚃", "🚂", "🚟", "🚤", "🛥", "⛵️"]),
    ]

    var body: some View {
        VStack {
            List {
                ForEach(groups, id: \.self.name) { group in
                    Section(header: Text(group.name)) {
                        ForEach(group.items, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }
        }.navigationTitle("collections")
    }
}

struct Demo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Demo()
        }
    }
}
