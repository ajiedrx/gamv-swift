//
//  GameListPage.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation
import SwiftUI
import SwiftUICore

struct GameListPage: View {
    @StateObject private var gameListViewModel: GameListViewModel

    @State var navigationPath: NavigationPath = NavigationPath()

    init(gameListViewModel: GameListViewModel) {
        _gameListViewModel = StateObject(wrappedValue: gameListViewModel)
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                switch gameListViewModel.listViewState {
                case .idle:
                    EmptyView()
                case .loading:
                    LoadingView()
                case .success(let gameList):
                    GameListView(
                        gameList: gameList,
                        navigationPath: $navigationPath
                    )
                case .failure(let failure):
                    ErrorView(
                        error: failure,
                        retryAction: gameListViewModel.getTopRatedGames
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(value: ToolbarRoutes.profile) {
                        Text("Profile")
                    }
                }
            }
            .navigationTitle("Games")
            .navigationDestination(for: ToolbarRoutes.self) { route in
                switch route {
                case .profile:
                    ProfileView()
                }
            }
        }
        .onAppear { gameListViewModel.getTopRatedGames() }
        .onDisappear { gameListViewModel.onViewDisappear() }
    }
}

struct GameListView: View {
    @State var gameList: [GameListItemModel]
    @Binding var navigationPath: NavigationPath

    var body: some View {
        List {
            ForEach(gameList) { game in
                GameItemView(
                    title: game.name, imageURL: game.backgroundImage,
                    releaseDate: game.released, rating: game.rating
                )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .scaleEffect(1.0)
                .animation(.spring(), value: navigationPath)
                .onTapGesture {
                    navigationPath.append(game)
                }
            }
        }
        .navigationDestination(for: GameListItemModel.self) { game in
            GameDetailPage(game: game)
        }
        .listRowSpacing(16)
        .scrollContentBackground(.hidden)
    }
}

struct GameItemView: View {
    let title: String
    let imageURL: String
    let releaseDate: String
    let rating: Double

    private let aspectRatio: CGFloat = 16 / 9
    private let cornerRadius: CGFloat = 24

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(aspectRatio, contentMode: .fill)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                        .brightness(-0.2)
                case .failure:
                    Image(systemName: "photo")
                case .empty:
                    ProgressView()
                @unknown default:
                    ProgressView()
                }
            }

            VStack {
                HStack {
                    Spacer()
                    Label(
                        title: {
                            Text(String(rating))
                                .foregroundColor(.white)
                        },
                        icon: {
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                        }
                    )
                    .font(.footnote)
                    .labelStyle(.titleAndIcon)
                    .padding()
                }
                Spacer()

                HStack {
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)

                        Text(
                            DateUtils.convertStringDate(
                                date: releaseDate, inputFormat: "yyyy-MM-dd",
                                outputFormat: "yyyy, dd MMM"
                            )
                        )
                        .foregroundColor(.white)
                        .font(.caption)
                    }
                    .padding()
                    Spacer()
                }
            }
        }.frame(height: 180)
    }
}

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .scaleEffect(1.5)
    }
}

struct ErrorView: View {
    let error: URLError
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Something went wrong")
                .font(.headline)

            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button("Retry") {
                retryAction()
            }
        }
        .padding()
    }
}

struct ButtonPressEffect: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)  // Smaller scale for faster response
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)  // Faster animation
    }
}

#Preview {
    GameListPage(
        gameListViewModel: GameListViewModel(
            gameUseCase: GameUseCaseImpl(
                gameRepository: MockGameRepository()
            )
        )
    )
}
