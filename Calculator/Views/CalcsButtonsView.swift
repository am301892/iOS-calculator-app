//
//  CalcsButtonsView.swift
//  Calculator
//
//  Created by Aleksandra Maksimowska 
//

import SwiftUI

struct CalcButtonModel: Identifiable{
    let id = UUID()
    let calcButton: CalcButton
    var color: Color = foregroundDigitsColor
}

struct RowOfCalcButtonsModel: Identifiable{
    let id = UUID()
    let row: [CalcButtonModel]
}

struct CalcsButtonsView: View {
    @Binding var currentComputation: String
    @Binding var mainResult: String
    
    let buttonData: [RowOfCalcButtonsModel] = [
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .clear, color: foregroundTopButtonsColor),
            CalcButtonModel(calcButton: .negative, color: foregroundTopButtonsColor),
            CalcButtonModel(calcButton: .percent, color: foregroundTopButtonsColor),
            CalcButtonModel(calcButton: .divide, color: foregroundRightButtonsColor),
            ]),
        
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .seven),
            CalcButtonModel(calcButton: .eight),
            CalcButtonModel(calcButton: .nine),
            CalcButtonModel(calcButton: .multiply, color: foregroundRightButtonsColor)
                                   ]),
        
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .four),
            CalcButtonModel(calcButton: .five),
            CalcButtonModel(calcButton: .six),
            CalcButtonModel(calcButton: .subtract, color: foregroundRightButtonsColor)
                                   ]),
        
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .one),
            CalcButtonModel(calcButton: .two),
            CalcButtonModel(calcButton: .three),
            CalcButtonModel(calcButton: .add, color: foregroundRightButtonsColor)
                                   ]),
        
        RowOfCalcButtonsModel(row: [
            CalcButtonModel(calcButton: .undo),
            CalcButtonModel(calcButton: .zero),
            CalcButtonModel(calcButton: .decimal),
            CalcButtonModel(calcButton: .equal, color: foregroundRightButtonsColor)
                                   ])
    ]
    var body: some View {
        Grid(){
            ForEach(buttonData){ rowOfCalcButtonsModel in
                GridRow{
                    ForEach(rowOfCalcButtonsModel.row){
                        calcButtonModel in
                        Button(action: {
                            buttonPressed(calcButton: calcButtonModel.calcButton)
                        },label: {
                            ButtonView(calcButton: calcButtonModel.calcButton, fgColor: calcButtonModel.color, bgColor: ButtonBackgroundColor)
                        })
                    }
                }
            }
        }
        .padding()
        .background(secondaryBackgroundColor
            .cornerRadius(20))
    }
    func buttonPressed(calcButton: CalcButton){
        switch calcButton {
        case .clear:
            currentComputation = ""
            mainResult = "0"
        
            
        case .add, .subtract, .divide, .multiply:
            if lastCharIsDigitOrPercent(str: currentComputation){
                appendToCurrentComputation(calcButton: calcButton)
            }
            
            
        case .decimal:
            if let lastOccurenceOfDecimal = currentComputation.lastIndex(of: "."){
                if lastCharIsDigit(str: currentComputation){
                    let startIndex = currentComputation.index(lastOccurenceOfDecimal,offsetBy: 1)
                    let endIndex = currentComputation.endIndex
                    let range = startIndex..<endIndex
                    let rightSubstring = String(currentComputation[range])
                    
                    //23.23+100 -> 23.23+100.
                    
                    if Int(rightSubstring) == nil && !rightSubstring.isEmpty{
                        currentComputation += "."
                    }
                    
                }
                
            }
            
            else {
                if currentComputation.isEmpty{
                    currentComputation += "0"
                } else if lastCharIsDigit(str: currentComputation){
                    currentComputation += "."
                }
            }
            
        case .percent:
            if lastCharIsDigit(str: currentComputation){
                appendToCurrentComputation(calcButton: calcButton)
            }
        case .negative, .equal:
            if !currentComputation.isEmpty{
                if !lastCharIsAnOperator(str: currentComputation){
                    
                    let sign = calcButton == .negative ? -1.0 : 1.0
                    
                    mainResult = formatResult(val: sign * calculateResults())
                    
                    if calcButton == .negative {
                        currentComputation = mainResult
                    }
//                    if(calcButton == .negative){
//                        sign = -1.0
//                    }else{
//                        sign = 1.0
//                    }
                }
            }
        case .undo:
            currentComputation = String(currentComputation.dropLast())
        default:
            appendToCurrentComputation(calcButton: calcButton)
        }
    }
    
    //implements the actual computation
    
    func calculateResults() -> Double{
        let visibleWorkings: String = currentComputation
        var workings = visibleWorkings.replacingOccurrences(of: "%", with: "*0.01")
        workings = workings.replacingOccurrences(of: multiplySymbol, with: "*")
        workings = workings.replacingOccurrences(of: divisionSymbol, with: "/")
        //example if we have "30." it will be replaced by 30.0
        if getLastChar(str: visibleWorkings) == "."{
            workings += "0"
        }
        //Actual computation
        let expr = NSExpression(format: workings)
        let expValue = expr.expressionValue(with: nil, context: nil) as! Double
        return expValue
    }
    func appendToCurrentComputation(calcButton: CalcButton){
        currentComputation += calcButton.rawValue
    }
}

#Preview {
    CalcsButtonsView(currentComputation: .constant("5+1"), mainResult: .constant("6"))
}
