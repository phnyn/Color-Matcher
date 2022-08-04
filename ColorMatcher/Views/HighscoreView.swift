//
//  HighscoreView.swift
//  Nguyen_Phuong_ColorMatcher
//
//  Created by Phuong  Nguyen on 01.08.22.
//

import SwiftUI
import CoreData

struct HighscoreView: View {
    //Holt die Daten
    @FetchRequest(sortDescriptors: [SortDescriptor(\.highscore, order: .reverse)]) var scores: FetchedResults<Highscore>
    
    let bronze = Color(UIColor(red: 147/255, green: 85/255, blue: 45/255, alpha: 1))
    
    var body: some View {
        VStack{
            Text("Highscores")
                    .font(.system(size: 25))
                    .padding(.vertical)

            //Auflistung der Scores
            List{
                ForEach(scores.indices) { i in
                    Label("\(scores[i].highscore)", systemImage: "circle.fill")
                        .accentColor(getColor(i: i))
                }
            }
        }
    }
    
    //Zuordnung der Farben 1.-3. Platz Gold,Silber,Bronze
    func getColor(i: Int) -> Color {
        var col: Color = .gray.opacity(0.1)
        switch i {
            case 0:
                col = .yellow;
            case 1:
                col = .gray;
            case 2:
                col = bronze;
            default:
            col = .gray.opacity(0.1)
        }
        return col;
    }
}

struct HighscoreView_Previews: PreviewProvider {
    static var previews: some View {
        HighscoreView()
    }
}
