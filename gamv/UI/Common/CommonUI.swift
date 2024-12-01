//
//  CommonUIState.swift
//  gamv
//
//  Created by Ajie DR on 01/12/24.
//

import Foundation
import SwiftUI

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
    let error: CommonError
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
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
    }
}
