import SwiftUI

struct GhostVStack<Content: View>: View {
  
  var spacing: CGFloat? = nil
  var alignment: HorizontalAlignment = .center
  @ViewBuilder var content: Content
  
  var body: some View {
    // LayoutView<GhostVStackLayout, Content>
    GhostVStackLayout(spacing: spacing, alignment: alignment) {
      content
    }
  }
}

struct GhostVStackLayout: Layout {
  
  var spacing: CGFloat? = nil // デフォルト値を設定するのもあり。
  var alignment: HorizontalAlignment = .center
  
  func sizeThatFits(
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout ()
  ) -> CGSize {
    // subviews の intrinsic size を把握する。
    let intrinsicSizes = subviews.map { $0.sizeThatFits(proposal) }
    
    // primary axis の合計値を計算する。
    let totalSubviewsHeight = intrinsicSizes.reduce(0) { $0 + $1.height }
    let totalSpacing = (spacing ?? 0) * CGFloat(intrinsicSizes.count - 1)
    let totalHeight = totalSubviewsHeight + totalSpacing
    
    // cross axis の最大値を計算する。
    let maxSubviewsWidth = intrinsicSizes.map(\.width).max() ?? 0
  
    return .init(width: maxSubviewsWidth, height: totalHeight)
  }

  func placeSubviews(
    in bounds: CGRect,
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout ()
  ) {
    var boundsMinY = bounds.minY
    
    // cross axis 方向に subview を整列させる。
    subviews.forEach { subview in
      let subviewSize = subview.sizeThatFits(proposal)
      let subviewWidth = subviewSize.width
      
      let x: CGFloat
      switch alignment {
      case .leading:
        x = bounds.minX
      case .center:
        x = bounds.midX - subviewWidth / 2
      case .trailing:
        x = bounds.maxX - subviewWidth
      default:
        x = bounds.minX
      }
      
      subview.place(at: .init(x: x, y: boundsMinY), proposal: .init(subviewSize))
      
      // その時点で描画可能な primary axis 方向の天井を更新する。
      boundsMinY += subviewSize.height + (spacing ?? 0)
    }
    
  }

}

struct ContentView: View {
  var body: some View {
    GhostVStack() {
      Button("a") {}
      Button("b") {}
    }
  }
}

print(ContentView.Body.self)
