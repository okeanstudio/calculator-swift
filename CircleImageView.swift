import SwiftUI

struct CircleImageView: View {
    var body: some View {
        Image("calculator_res").resizable().frame(width: 120, height: 120).clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct LogCircleImageView: View {
    var body: some View {
        Image("login").resizable().frame(width: 120, height: 120).clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    LogCircleImageView()
}
