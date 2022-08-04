//
//  ContentView.swift
//  Nguyen_Phuong_ColorMatcher
//
//  Created by Phuong  Nguyen on 07.07.22.
//

import SwiftUI
struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    //Random Color: 2. Kommastellen
    static var r: Double = (Double.random(in: 0..<1)*100).rounded()/100
    static var g: Double = (Double.random(in: 0..<1)*100).rounded()/100
    static var b: Double = (Double.random(in: 0..<1)*100).rounded()/100
    static var rdmColor = Color(red: r, green: g, blue: b)
    
    //Color Match
    @State var redValue: Double = 0
    @State var greenValue: Double = 0
    @State var blueValue: Double = 0
    
    @State var showingAlert = false;
    @State var showingSheet = false;
    @State var result: Int = 0
    
    var body: some View {
        VStack{
            // Randomized Color
            VStack{
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .foregroundColor(ContentView.rdmColor)
            }.shadow(color: .gray, radius: 15, x: 5, y: 5)
            .padding(.vertical)
            .frame(width: .infinity, height: .infinity, alignment: .top)
            
            // RGB values of the randomized color
            Text("R: \(Int(ContentView.r*255)) G: \(Int(ContentView.g*255)) B: \(Int(ContentView.b*255))")
                  
            //Color Match
            VStack{
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .foregroundColor(Color(red: redValue, green: greenValue, blue: blueValue))
            } .shadow(color: .gray, radius: 15, x: 5, y: 5)
            .padding(.vertical)
            .frame(width: .infinity, height: .infinity, alignment: .center)

            // Sliders
            VStack{
                VStack{
                    Slider(value: $redValue, in: 0...1, step: 0.01){
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("255")
                    }.tint(.red)

                    Slider(value: $greenValue, in: 0...1, step: 0.01){
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("255")
                    }.tint(.green)
                    
                    Slider(value: $blueValue, in: 0...1, step: 0.01){
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("255")
                    }.tint(.blue)
                    
                    /*Text("R: \(Int(redValue*255)) G: \(Int(greenValue*255)) B: \(Int(blueValue*255))") */
                    
                }.padding()
            }.frame(width: .infinity, height: 140, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 16).fill(.white).shadow(color: .gray, radius: 10, x: 5, y: 5))

            // Button
            VStack{
                Button("Hit Me"){
                    //Berechnung der Punkte
                    result = RGBColor(r: ContentView.r, g: ContentView.g, b: ContentView.b).evaluate(red: redValue, green: greenValue, blue: blueValue)
                    
                    //Speicherung des Scores
                    DataController().addScore(score: result, context: moc)
                    
                    showingAlert = true
                }
                .alert("Das Ergebnis", isPresented: $showingAlert){
                    Button("Try Again"){
                        //Neugenerierung der Farbe
                        randomizeColor()
                        showingAlert = false;
                    }
                    
                    Button("Highscores"){
                        showingSheet = true
                        
                        //Wenn Highscore geschlossen -> neues Level
                        randomizeColor()
                    }
                } message: {
                    Text("Du hast \(result) Punkte erreicht")
                }
            }
            .frame(width: 240, height: 40, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 20).fill(.white).shadow(color: .gray, radius: 10, x: 5, y: 5))
            .padding(.vertical)
            
            // Aufruf der Highscores in einen Sheet
            .sheet(isPresented: $showingSheet){
                HighscoreView()
            }
            
        }.padding(.horizontal)
        .frame(width: .infinity, height: .infinity, alignment: .bottom)
    }
    
    //Neugenerieung einer Farbe
    func randomizeColor(){
        let rgb = RGBColor()
        ContentView.r = rgb.red
        ContentView.g = rgb.green
        ContentView.b = rgb.blue
        ContentView.rdmColor = rgb.rdmColor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
