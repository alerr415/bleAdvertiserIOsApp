//
//  OnBoardView.swift
//  bleAdvertiser1
//
//  Created by SwiftApp on 2021. 05. 14..
//

import SwiftUI
import Firebase
import GoogleSignIn

struct OnBoardView: View {
    @State var onBoard = [
        Board(title: "BLE Advertiser App", detail: "BLE Advertiser App", pic: "logo"),
    ]
    
    @State var index = 0
    
    var body: some View {
        
        VStack{
            
            Image(self.onBoard[self.index].pic)
            .resizable()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            .padding(.top,30)
            
            Text(self.onBoard[self.index].title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 35)
            
            Spacer(minLength: 0)
            
            Button(action: {
                // Google Sign In....
                // Calling ...
                GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                GIDSignIn.sharedInstance()?.signIn()
                
            }) {
                
                HStack(spacing: 30){
                    
                    // Changing Text When Last Screen Appears..
                    if self.index == 0{
                        
                        Image("google")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                    }
                    
                    Text("Sign in")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                }
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 200)
                .background(Color.primary)
                .clipShape(Capsule())
                .padding(.bottom, 20)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView()
    }
}
