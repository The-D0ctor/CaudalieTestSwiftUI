//
//  ContentView.swift
//  CaudalieTestSwiftUI
//
//  Created by Sébastien Rochelet on 05/06/2023.
//

import SwiftUI

struct MediaListView: View {
    @State private var searchText: String = ""
    @EnvironmentObject var mediaListViewModel: MediaListViewModel
    
    let progressView = ProgressView()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Results: ")
                        .font(.headline)
                    Text(String(mediaListViewModel.medias.count))
                        .font(.subheadline)
                }
                .padding(.leading, 20.0)
                    List(mediaListViewModel.medias) { media in
                        NavigationLink {
                            MediaDetailsView(media: media)
                        } label: {
                            MediaRow(media: media)
                        }
                    }
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            mediaListViewModel.getMediaList(title: searchText)
        }.overlay {
            if (mediaListViewModel.isGettingMedias) {
                progressView
            }
        }.alert(isPresented: $mediaListViewModel.isError, error: mediaListViewModel.error) { _ in
            Button("Ok", role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}

struct MediaList_Previews: PreviewProvider {
    static var previews: some View {
        MediaListView().environmentObject(MediaListViewModel())
    }
}
