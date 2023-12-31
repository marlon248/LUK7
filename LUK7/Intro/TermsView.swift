//
//  TermsView.swift
//  LUK7
//
//  Created by Elier Ayala Bernal on 2023-08-11.
//

import SwiftUI

struct TermsView: View {
    @State var terms: [TermsModel] = [TermsModel(title: "Last updated: October 13, 2023", body: "Welcome to our application. Your privacy is a priority for us, and we want to make sure you understand how we protect your data. This Privacy Policy describes how we handle information in relation to your use of our mobile application. By continuing to use our application, you accept the practices described in this policy.", show: true), TermsModel(title: "Collection and Use of Information", body:
"""
1. We Do Not Collect Personal Data: We want you to have peace of mind knowing that we do not collect any personal, financial or confidential data through our application. We do not request or store personally identifiable information, card numbers, passwords or other sensitive information.

2. We Do Not Store Information on External Servers: To reinforce our commitment to your privacy, we assure you that we never transmit information of any kind to external servers. All information generated by your use of the application is maintained on your device.

3. We Do Not Collect Usage Information: We respect your privacy to the fullest. We do not track or collect information about how you use our app. We do not store data about your activities, location, interactions or behaviors.

""", show: true), TermsModel(title: "Disclaimer", body:
"""
1. Use at Your Own Responsibility: We want to emphasize that the use of our application is at your own risk. We are not responsible for any consequences, errors, omissions or actions resulting from the use of the application. Each user is responsible for ensuring that the operations performed are accurate and appropriate.
""", show: false), TermsModel(title: "Acceptance of the Privacy Policy", body:
"""
By continuing to use our application, you are accepting the practices described in this Privacy Policy.
""", show: true), TermsModel(title: "Changes to the Privacy Policy", body:
"""
We reserve the right to update or modify this Privacy Policy at any time without prior notice. Any changes to this Privacy Policy will be effective when posted on this page. We recommend that you periodically review this page to be aware of any changes. Your continued use of the application following the posting of changes will constitute your acceptance of such changes..
""", show: true), TermsModel(title: "Contact", body:
"""
If you have any questions about this Privacy Policy, you can contact us at [marlonrivero1999@gmail.com](mailto:marlonrivero1999@gmail.com) for more information.
""", show: true)]
    
    @State private var isChecked = false
    @AppStorage("isNotCheckedTerms") var isNotCheckedTerms = true

    var body: some View {
        NavigationView {
            ScrollView {
             
                Group {
                    ForEach(terms, id:\.title){ text in
                        if text.show { // mostrar la politoca segun se va actualizando la app con nuevas funciones
                            Text("\(text.title)")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.top, .horizontal])
                            Text(.init(text.body))
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .padding(.top, 8)
                        }
                    }
                    
                    Button {
                        isChecked.toggle()
                    } label: {
                        HStack {

                            Image(systemName: (isChecked) ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor((isChecked) ? .blue : .gray)
                                .font(.system(size: 20, weight: .bold, design: .default))
                           
                            Text("terms_mejs")
                                .lineLimit(3)
                                .foregroundColor((isChecked) ? .blue : .gray)
                                .frame(maxWidth: .infinity)
                        }
                    }
                        .controlSize(.large)
                        .padding(.horizontal)
                        .padding(.top)

                    
                    
                }.padding(.bottom, 130)
                
            }
            .interactiveDismissDisabled()
            .overlay(alignment: .bottom, content: {
                HStack {
                    
                    Button {
                        isNotCheckedTerms = false
                    } label: {
                        Text("terms_continu")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.horizontal)
                        
                    
                }.frame(height: 100)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()
                .background(.ultraThinMaterial)
                .disabled(!isChecked)
            })
            .navigationTitle("terms_title")
        }.navigationViewStyle(.stack)
    }
}

struct TermsModel: Decodable, Hashable {
    var title: String
    var body: String
    var show: Bool
}
