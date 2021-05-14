//
//  ContentView.swift
//  bleAdvertiser1
//
//  Created by SwiftApp on 2021. 05. 07..
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    
    @State var user = Auth.auth().currentUser
    
    var body: some View {
        
        // Updating View Based On User Login...
        
        VStack{
            
            if user != nil{
                
                //Home()
                HomeView()
            }
            else{
                
                //OnBoard()
                OnBoardView()
            }
        }
        //.onDisappear {
            
            //NotificationCenter.default.addObserver(forName: NSNotification.Name("SIGNOUT"), object: nil, queue: .main) { (_) in
                // Updating User..
                //self.user = Auth.auth().currentUser
            //}
        //}
        .onAppear {
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("SIGNIN"), object: nil, queue: .main) { (_) in
                // Updating User..
                self.user = Auth.auth().currentUser
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct OnBoard : View {
    
    @State var onBoard = [

        Board(title: "BLE Advertiser App", detail: "BLE Advertiser App", pic: "logo"),
        
        /*Board(title: "Social Media", detail: "Social media are interactive computer-mediated technologies that facilitate the creation or sharing of information, ideas, career interests and other forms of expression via virtual communities and networks.", pic: "b2"),
        
        Board(title: "Software Development", detail: "Software development is the process of conceiving, specifying, designing, programming, documenting, testing, and bug fixing involved in creating and maintaining applications, frameworks, or other software components.", pic: "b3"),*/

    ]
    
    @State var index = 0
    
    var body: some View{
        
        VStack{
            
            Image(self.onBoard[self.index].pic)
            .resizable()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
            
            // Pages...
            
            /*HStack(spacing: 12){
                
                ForEach(0..<self.onBoard.count,id: \.self){i in
                    
                    Circle()
                        .fill(self.index == i ? Color.gray : Color.black.opacity(0.07))
                        .frame(width: 10, height: 10)
                }
            }*/
            .padding(.top,30)
            
            Text(self.onBoard[self.index].title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 35)
            
            /*Text(self.onBoard[self.index].detail)
                .foregroundColor(.black)
                .padding(.top)
                .padding(.horizontal, 20)*/
            
            Spacer(minLength: 0)
            
            Button(action: {
                
                // Updating index...
                
                /*if self.index < self.onBoard.count - 1{
                    
                    self.index += 1
                }
                else{*/
                    
                    // Google Sign In....
                    // Calling ...
                
                    GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
                    
                    GIDSignIn.sharedInstance()?.signIn()
                //}
                
            }) {
                
                HStack(spacing: 30){
                    
                    // Changing Text When Last Screen Appears..
                    
                    //if self.index == self.onBoard.count - 1{
                    if self.index == 0{
                        
                        Image("google")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                    }
                    
                    //Text(self.index == self.onBoard.count - 1 ? "Login" : "Next")
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

// Main Home View...

struct Home : View {
    @State private var onOff = false
    
    var body: some View{
        
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
                    Text("Ale")
                }
            
            
            Button("Sign out", action: {
                logOut()
            })
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 200)
            .background(Color.primary)
            .clipShape(Capsule())
            .padding(.bottom, 20)
            .foregroundColor(.white)
        }
    }
    
    // LogOut From Firebase
    
    // Call This When To Perform LogOut...
    func logOut(){
        
        // Logout From Google...
        
        GIDSignIn.sharedInstance()?.signOut()
        
        try! Auth.auth().signOut()
        
        //send user to boardView
    }
}

// Sample Data...

struct Board {
    
    var title : String
    var detail : String
    var pic : String
}


