//
//  GameLogic.swift
//  Nguyen_Phuong_ColorMatcher
//
//  Created by Phuong  Nguyen on 28.07.22.
//

import Foundation
import SwiftUI

// Eine RGB Farbe
class RGBColor{
    var red: Double
    var green: Double
    var blue: Double
    var rdmColor: Color
    
    // Konstruktor
    init(){
        //2.te Kommastelle
        red = (Double.random(in: 0..<1)*100).rounded()/100
        green = (Double.random(in: 0..<1)*100).rounded()/100
        blue = (Double.random(in: 0..<1)*100).rounded()/100
        rdmColor = Color(red: red, green: green, blue: blue)
    }
    
    //Konstruktor mir Parametern
    init(r: Double, g: Double, b: Double){
        red = r
        green = g
        blue = b
        rdmColor = Color(red: r, green: g, blue: b)
    }
    
    //Berechnet die Distanz der R,G,B Werte und verteilent einen 'Score'
    func evaluate(red: Double, green: Double, blue: Double) -> Int{
        //Differenz berechnen
        let r = abs(self.red - red)
        let g = abs(self.green - green)
        let b = abs(self.blue - blue)
        
        //Durchschnitt der RGB Distanz
        let result = ((r+g+b)/3)*100
        
        //Substraktion der Distanz von 100, da man 100 Punkte erreichen kann
        return Int(100 - result.rounded())
    }
}

//Generierung einer zufälligen Farbe
func randomColor() -> Color {
    //Hat 2 Kommastellen
    let red = (Double.random(in: 0..<1)*100).rounded()/100
    let green = (Double.random(in: 0..<1)*100).rounded()/100
    let blue = (Double.random(in: 0..<1)*100).rounded()/100
    return Color(red: red, green: green, blue: blue)
}
