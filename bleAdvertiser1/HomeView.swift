//
//  HomeView.swift
//  bleAdvertiser1
//
//  Created by SwiftApp on 2021. 05. 14..
//

import SwiftUI
import Firebase
import GoogleSignIn

struct HomeView: View {
    @State private var onOff = false
    var body: some View {
        VStack{
            
            Text("Logged In As:")
                .multilineTextAlignment(.center)
                .padding(.top,30)
            
            Text("User ID: \(Auth.auth().currentUser!.uid)")
                .multilineTextAlignment(.leading)
                .padding(.top,30)
            
            Text("Name: \(Auth.auth().currentUser!.displayName!)")
                .multilineTextAlignment(.leading)
                .padding(.top,30)
            
            Text("E-mail: \(Auth.auth().currentUser!.email!)")
                .multilineTextAlignment(.leading)
                .padding(.top,30)
                .padding(.bottom, 30)
            
            Toggle("Advertising ON/OFF", isOn: $onOff)
                .toggleStyle(SwitchToggleStyle(tint: .green))
                .padding(.bottom, 30)
                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                if onOff {
                    Text("New views")
                }
            
            Button("Sign out", action: {
                GIDSignIn.sharedInstance()?.signOut()
                
                try! Auth.auth().signOut()
            })
            .onTapGesture {
                ContentView()
            }
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 200)
            .background(Color.primary)
            .clipShape(Capsule())
            .padding(.bottom, 20)
            .foregroundColor(.white)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
