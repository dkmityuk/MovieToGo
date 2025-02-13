//
//  DetailView.swift
//  MovieToGo
//
//  Created by Dmytro Kmytiuk on 12.02.2025.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: DetailViewModel
    @State var isShowAlert = false
        
    var body: some View {
        GeometryReader { screen in
            VStack(alignment: .center) {
                customNavigationBar()
                
                ZStack(alignment: .bottom) {
                    KFImage(.tmdbImage(path: viewModel.movie?.backdrop_path))
                        .resizable()
                        .frame(width: screen.size.width * 0.95, height: screen.size.height * 0.3 )
                        .cornerRadius(8)
                        .overlay(constructGradientOverlay())
                        .overlay {
                            Button {
                                isShowAlert = true
                            } label: {
                                Image("playButton")
                            }
                        }
                        .padding(.top)
                    
                    HStack {
                        Text(viewModel.movie?.title ?? "")
                            .font(.detaTitleFont)
                            .foregroundStyle(.white)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Text(viewModel.movie?.vote_average.roundedString() ?? "")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.accentOrange)
                            .frame(width: 16, height: 16)
                            .clipped()
                            .padding(.trailing)
                    }
                    .padding()
                }
                
                VStack(alignment: .leading) {
                    Text("Description:")
                        .font(.detaTitleFont)
                        .foregroundStyle(.black)
                    
                    Text(viewModel.movie?.overview ?? "")
                        .font(.detailOverviewFont)
                        .foregroundColor(.mainGray)
                        .padding(.top)
                    
                    Text("Release: \(viewModel.movie?.release_date ?? "")")
                        .font(.detailDateFont)
                        .padding(.vertical, 8)
                        .foregroundColor(.accentOrange)
                }
                .padding()
                
                Spacer()
                
            }
            .navigationBarHidden(true)
        }
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.loadMovie()
            }
            .alert(isPresented: $isShowAlert) {
                Alert(
                    title: Text(viewModel.movie?.title ?? "Unknown Movie"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
}
private extension DetailView {
    func constructGradientOverlay() -> some View {
        LinearGradient(
            gradient: Gradient(colors: [.black.opacity(0.7), .clear]), startPoint: .bottom, endPoint: .top
        )
        .cornerRadius(8)
    }
    
    func customNavigationBar() -> some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.accentOrange)
            }
            
            Spacer()
            
            Image("logo")

            Spacer()
        }
        .padding(.horizontal)
    }
}
