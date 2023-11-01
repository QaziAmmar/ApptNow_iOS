//
//  CountDownView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 29/07/2023.
//

import SwiftUI

struct CountDownView: View {
    @State private var secondsRemaining = 59
    @State private var isTimerActive = true
    @Binding var startTimer: Bool

    var body: some View {
        HStack {
            Image(systemName: "clock")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.color(.secondaryText))

            Text("\(secondsRemaining)s")
                .font(Font.system(size: 16))
                .foregroundColor(.color(.secondaryText))

        }
        .onAppear {
            if startTimer {
                resetTimer()
            }
        }
        .onChange(of: startTimer) { newValue in
            if newValue {
                resetTimer()
            }
        }
    }

    private func resetTimer() {
        isTimerActive = true
        secondsRemaining = 59

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                timer.invalidate()
                isTimerActive = false
            }
        }
    }
}

struct CountDownView_Previews: PreviewProvider {
    static var previews: some View {
        CountDownView(startTimer: .constant(true))
    }
}
