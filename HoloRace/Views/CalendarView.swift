//
//  CalendarView.swift
//  HoloRace
//
//  Created by Wiktor Jankowski on 16/05/2022.
//

import SwiftUI

struct CalendarView: View {
    //var namespace: Namespace.ID
    @State private var showingAlert = false
    @State private var date = Date()
    @Environment(\.presentationMode) private var presentationMode
        let dateRange: ClosedRange<Date> = {
            let calendar = Calendar.current
            let startComponents = DateComponents(year: 2022, month: 07, day: 13, hour: 12, minute: 00, second: 00)
            let endComponents = DateComponents(year: 2022, month: 07, day: 17, hour: 22, minute: 00, second: 00)
            return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
        }()
    init() {
                UIDatePicker.appearance().minuteInterval = 30
            }
        var body: some View {
            ZStack{
                VStack{
                    DatePicker(
                        "Pick a date",
                        selection: $date,
                        in: dateRange,
                        displayedComponents: [.date, .hourAndMinute])
                        .padding()
                        .datePickerStyle(.graphical)
                        .padding()
                        .accentColor(.blue)
                        .environment(\.locale, .init(identifier: "us"))
                    Button("Book now!") {
                        showingAlert = true
                    }
                    .padding(.top,20)
                    .font(.headline)
                    //.blendMode(.overlay)
                    .buttonStyle(.angular)
                    .tint(.accentColor)
                    .controlSize(.large)
                    .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
                    .alert("You have succesfully booked your HoloRace!", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) {self.presentationMode.wrappedValue.dismiss() }
                            }
                }
            }
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .background(
                Image("Blob 1").offset(x: -100, y: -200)
            )
        }
        
        
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
            .environmentObject(Model())
    }
}
