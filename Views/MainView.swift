import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {

                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // MARK: Display
                    HStack {
                        Spacer()
                        Text(viewModel.value)
                            .foregroundStyle(.white)
                            .font(.system(size: 90))
                            .fontWeight(.light)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                    
                    // MARK: Buttons
                    ForEach(viewModel.buttonsArray, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { item in
                                Button {
                                    viewModel.didTap(item: item)
                                } label: {
                                    Text(item.rawValue)
                                        .frame(
                                            width: viewModel.buttonWidth(item: item, geometry: geometry),
                                            height: viewModel.buttonHeight(geometry: geometry)
                                        )
                                        .foregroundStyle(item.buttonFontColor)
                                        .background(item.buttonColor)
                                        .font(.system(size: 35))
                                        .cornerRadius(40)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(ViewModel())
}
