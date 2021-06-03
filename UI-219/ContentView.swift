//
//  ContentView.swift
//  UI-219
//
//  Created by にゃんにゃん丸 on 2021/06/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    @State var wish = false
    @State var endWish = false
    var body: some View{
        
        ZStack{
            
            VStack{
                
                
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: getRect().width / 1.5)
                    .cornerRadius(10)
                
                
                Text("Happy Birthday\nBaear")
                    .font(.custom("Limelight-Regular", size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(.purple)
                    .lineSpacing(12)
                    .multilineTextAlignment(.center)
                
                Button(action: doAnimation, label: {
                    Text("Wish")
                        .font(.custom("Limelight-Regular", size: 15))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .padding(.horizontal,30)
                        .background(Color.primary)
                        .clipShape(Capsule())
                })
                .disabled(wish)
                
            }
            
            EmiterView()
                .scaleEffect(wish  ? 1 : 0,anchor: .top)
                .opacity(wish && !endWish ? 1 : 0)
                .offset(y: wish ? 0 : getRect().height / 2)
               
                .ignoresSafeArea()
            
        }
    }
    
    func doAnimation(){
        
        
        withAnimation(.spring()){
            
            wish = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            withAnimation(.easeOut(duration: 0.3)){
                
                endWish = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                wish = false
                endWish = false
            }
        }
        
        
    }
}

func getRect()->CGRect{
    
    
    return UIScreen.main.bounds
}

struct EmiterView : UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let emitterLayer = CAEmitterLayer()
        
        
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = CreateEmitterCell()
        
        emitterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        
        emitterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        
        
        
        
        
        
        view.layer.addSublayer(emitterLayer)
        
        return view
        
        
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func CreateEmitterCell() -> [CAEmitterCell]{
        
        
        var emittercells : [CAEmitterCell] = []
        
        
        for index in 1...12{
            
            let cell = CAEmitterCell()
            cell.contents = UIImage(named: getImae(index: index))?.cgImage
            cell.color = getColor().cgColor
            
            cell.birthRate = 5
            cell.lifetime = 10
            cell.scale = 0.3
            cell.velocity = 120
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.3
            cell.spin = 3.5
            cell.spinRange = 1
            cell.yAcceleration = 30
           emittercells.append(cell)
            
            
        }
        
        return emittercells
        
    
        
        
        
    }
    
    func getImae(index : Int) -> String{
        
        if index < 4 {
            
            return "rectangle"
        }
        
        else if index > 5 && index <= 8{


            return "circle"
        }

        else{
            
            return "triangle"
        }
        
        
        
    }
    
    
    func getColor()->UIColor{
        
        let colors :[UIColor] = [.systemRed,.systemBlue,.systemPink,.systemGreen
        
            
        ]
        
        return colors.randomElement()!
        
        
    }
}
