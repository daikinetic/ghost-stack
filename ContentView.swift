import SwiftUI

struct ContentView: View {
  var body: some View {
    ScrollView {
      HStack(alignment: .top, spacing: 16) {
        
        // VStack
        VStack(alignment: .leading, spacing: 4) {
          Text("🧱 VStack")
            .font(.headline)
          ForEach(0..<200, id: \.self) { i in
            Text("Item \(i)")
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.vertical, 2)
              .background(i.isMultiple(of: 2) ? .gray.opacity(0.1) : .clear)
          }
        }
        .padding()
        .background(.blue.opacity(0.05))
        .cornerRadius(8)
        
        // GhostVStack
        GhostVStack(spacing: 4, alignment: .leading) {
          Text("👻 GhostVStack")
            .font(.headline)
          ForEach(0..<200, id: \.self) { i in
            Text("Item \(i)")
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.vertical, 2)
              .background(i.isMultiple(of: 2) ? .gray.opacity(0.1) : .clear)
          }
        }
        .padding()
        .background(.green.opacity(0.05))
        .cornerRadius(8)
      }
      .padding()
    }
  }
}
