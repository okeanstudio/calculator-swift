import SwiftUI

struct ContentView: View {

    @State private var goToAuthView: Bool = false
    @State private var goToMainView: Bool = false
    @State private var isFirstLaunch: Bool = true
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                if goToMainView {
                    MainView()
                        .environmentObject(viewModel)
                        .transition(.move(edge: .trailing))
                } else {
                    VStack {
                        if goToAuthView {
                            AuthView(goToAuthView: $goToAuthView, goToMainView: $goToMainView)
                                .transition(.move(edge: .trailing))
                        } else {
                            HelloView(goToAuthView: $goToAuthView)
                                .transition(.move(edge: .leading))
                        }
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: goToAuthView)
        .animation(.easeInOut(duration: 0.5), value: goToMainView)
        .navigationTitle(Text(""))
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        .onAppear {
            checkFirstLaunch()
        }
    }
    
    private func checkFirstLaunch() {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        
        if hasLaunchedBefore {
            goToMainView = true
        } else {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            goToMainView = false
        }
    }
}

struct HelloView: View {

    @Binding var goToAuthView: Bool

    var body: some View {

        Spacer()

        VStack {

            CircleImageView()
                .offset(y: -40)

            VStack(alignment: .center) {

                Text("Добро пожаловать!")
                    .font(.largeTitle)
                    .foregroundStyle(Color.orange)

                Text("Калькулятор - решайте математические задачи прямо в приложении")
                    .font(.subheadline)
                    .padding(.top, 1)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
            }
        }
        .offset(y: -30)

        Spacer()

        VStack {

            Button(action: {

                withAnimation {
                    goToAuthView = true
                }

            }) {

                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.orange)
                    .frame(height: 60)
                    .overlay {

                        Text("Далее")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 40)
            }
            .offset(y: -20)
        }
    }
}

struct AuthView: View {
    
    @Binding var goToAuthView: Bool
    @Binding var goToMainView: Bool

    var body: some View {

        Spacer()

        VStack {

            LogCircleImageView()
                .offset(y: -40)

            VStack(alignment: .center) {

                Text("Калькулятор")
                    .font(.largeTitle)
                    .foregroundStyle(Color.orange)

                Text("Простой и удобный калькулятор для ваших повседневных задач")
                    .font(.subheadline)
                    .padding(.top, 1)
                    .padding(.horizontal, 30)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
            }
        }
        .offset(y: -30)

        Spacer()

        VStack {

            Button(action: {
                withAnimation {
                    goToMainView = true
                }
            }) {
                
                VStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.orange)
                        .frame(height: 60)
                        .overlay {
                            
                            Text("Начать использование")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                    
                    Button(action: {
                        withAnimation {
                            goToAuthView = false
                        }
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Назад")
                        }
                        .foregroundColor(.gray)
                        .font(.headline)
                    }
                    .padding(.top, 5)
                }
            }
            .offset(y: -20)
        }
    }
}

#Preview {
    ContentView()
}
