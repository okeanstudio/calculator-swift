import SwiftUI
import Combine

class ViewModel: ObservableObject {
    
    // MARK: Property
    @Published var value = "0"
    @Published var number: Double = 0.0
    @Published var currentOperation: Operation = .none
    
    let buttonsArray: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    func didTap(item: Buttons) {
        switch item {
        case .plus, .minus, .multiply, .divide:
            currentOperation = item.buttonToOperation()
            number = Double(value) ?? 0
            value = "0"
        case .equal:
            if let currentValue = Double(value) {
                value = formatResult(performOperation(currentValue))
            }
        case .decimal:
            if !value.contains(".") {
                value += "."
            }
        case .percent:
            if let currentValue = Double(value) {
                value = formatResult(currentValue / 100)
            }
        case .negative:
            if let currentValue = Double(value) {
                value = formatResult(-currentValue)
            }
        case .clear:
            value = "0"
        default:
            if value == "0" {
                value = item.rawValue
            } else {
                value += item.rawValue
            }
        }
    }
    
    func performOperation(_ currentValue: Double) -> Double {
        switch currentOperation {
        case .addition:
            return number + currentValue
        case .subtract:
            return number - currentValue
        case .multiply:
            return number * currentValue
        case .divide:
            return number / currentValue
        default:
            return currentValue
        }
    }
    
    func formatResult(_ result: Double) -> String {
        return String(format: "%g", result)
    }
    
    func buttonWidth(item: Buttons, geometry: GeometryProxy) -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing = spacing * 5
        let totalColumns: CGFloat = 4
        let screenWidth = geometry.size.width
        
        if item == .zero {
            return (screenWidth - totalSpacing) / totalColumns * 2 + spacing
        }
        
        return (screenWidth - totalSpacing) / totalColumns
    }
    
    func buttonHeight(geometry: GeometryProxy) -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing = spacing * 5
        let totalColumns: CGFloat = 4
        let screenWidth = geometry.size.width
        
        return (screenWidth - totalSpacing) / totalColumns
    }
}
