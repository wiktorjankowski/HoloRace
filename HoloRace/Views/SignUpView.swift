//
//  SignUpView.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 11/05/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SignUpView: View {
    enum Field: Hashable {
        case email
        case password
    }
    
    private var db = Firestore.firestore()
    @State var email = ""
    @State var password = ""
    @State var username = ""
    @State var signUpProcessing = false
    @State var userCreated = false
    @State var signUpErrorMessage = ""
    @FocusState var focusedField: Field?
    @State var circleY: CGFloat = 0
    @State var emailY: CGFloat = 0
    @State var passwordY: CGFloat = 0
    @State var circleColor: Color = .blue
    @EnvironmentObject var model: Model
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sign up")
                .font(.largeTitle).bold()
            Text("Step into our world. The HoloRace")
                .font(.headline)
            TextField("Name and surname", text: $username)
                .inputStyle(icon: "person")
                //.textContentType(.emailAddress)
                //.keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                //.focused($focusedField, equals: .email)
                //.shadow(color: focusedField == .email ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                .overlay(geometry)
               // .onPreferenceChange(CirclePreferenceKey.self) { value in
                    //emailY = value
                    //circleY = value
                //}
            TextField("Email", text: $email)
                .inputStyle(icon: "mail")
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .focused($focusedField, equals: .email)
                .shadow(color: focusedField == .email ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                .overlay(geometry)
                .onPreferenceChange(CirclePreferenceKey.self) { value in
                    emailY = value
                    circleY = value
                }
            SecureField("Password", text: $password)
                .inputStyle(icon: "lock")
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .shadow(color: focusedField == .password ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                .overlay(geometry)
                .onPreferenceChange(CirclePreferenceKey.self) { value in
                    passwordY =  value
                }
            Button {
                signUpUser(userEmail: email, userName: username, userPassword: password)
                HomeView()
            } label: {
                Text("Create an account")
                    .frame(maxWidth: .infinity)
            }
            .font(.headline)
            .blendMode(.overlay)
            .buttonStyle(.angular)
            .tint(.accentColor)
            .controlSize(.large)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
            
            Group {
                Text("By clicking on ")
                + Text("_Create an account_").foregroundColor(.primary.opacity(0.7))
                + Text(", you agree to our **Terms of Service** and **[Privacy Policy](https://designcode.io)**")
                
                Divider()
                
                HStack {
                    Text("Already have an account?")
                    Button {
                        model.selectedModal = .signIn
                    } label: {
                        Text("**Sign in**")
                    }
                }
            }
            .font(.footnote)
            .foregroundColor(.secondary)
            .accentColor(.secondary)
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .background(
            Circle().fill(circleColor)
                .frame(width: 68, height: 68)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .offset(y: circleY)
        )
        .coordinateSpace(name: "container")
        .strokeStyle(cornerRadius: 30)
        .onChange(of: focusedField) { value in
            withAnimation {
                if value == .email {
                    circleY = emailY
                    circleColor = .blue
                } else {
                    circleY = passwordY
                    circleColor = .red
                }
            }
        }
    }
    
    var geometry: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: CirclePreferenceKey.self, value: proxy.frame(in: .named("container")).minY)
        }
    }
    func signUpUser(userEmail: String, userName: String, userPassword: String) {
        
        signUpProcessing = true
        userCreated = false
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { result, error in
            do {
                let id = result?.user.uid
                db.collection("holorace").document(id ?? "").setData([
                "id":id,
                "email":email,
                "username":username])
               /* let _ = try db.collection("users").addDocument(data: ["id":userID, "email": email, "username": username])*/
                //viewRouter.currentPage = .signInPage
            }
            catch{
                print(error)
            }
            /*authResult, error in
            guard error == nil else {
                signUpErrorMessage = error!.localizedDescription
                signUpProcessing = false
                return
            }
            
            switch authResult {
            case .none:
                print("Could not create account.")
                signUpProcessing = false
            case .some(_):
                print("User created")
                userCreated=true
                signUpProcessing = false
                viewRouter.currentPage = .signInPage
            }
            
            */
        }
       // let id = authResult?user.uid
       /* if(userCreated==true)
        {
            _ = try db.collection("users").addDocument(data: ["id":userID, "email": email, "username": username])
        }*/
        
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignUpView()
                .preferredColorScheme(.light)
                .environmentObject(Model())
        }
    }
}



