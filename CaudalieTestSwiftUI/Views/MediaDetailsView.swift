//
//  MediaDetailsView.swift
//  CaudalieTestSwiftUI
//
//  Created by Sébastien Rochelet on 06/06/2023.
//

import SwiftUI

struct MediaDetailsView: View {
    var media: Media
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: media.artworkUrl100 ?? "")) { phase in
                if let image = phase.image {
                    image.resizable()
                }
                else if phase.error != nil {
                    Image("image-not-found-icon").resizable()
                }
                else {
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            if media.trackName != nil {
                Text(media.trackName!)
                    .padding(.vertical, 10.0)
            }
            if media.artistName != nil {
                Text(media.artistName!)
                    .padding(.vertical, 10.0)
            }
            if media.collectionName != nil {
                Text(media.collectionName!)
                    .padding(.vertical, 10.0)
            }
            if media.longDescription != nil {
                Text(media.longDescription!)
                    .padding(.vertical, 10.0)
            }
            if media.trackViewUrl != nil, let url = URL(string: media.trackViewUrl!) {
                Link(media.trackViewUrl!, destination: url)
                    .padding(.vertical, 10.0)
                    
            }
            Spacer()
        }
    }
}

struct MediaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetailsView(media: Media(artistName: "test", collectionName: "test", trackName: "test", trackViewUrl: "https://music.apple.com/us/album/nel-sole-live/1310669695?i=1310670411&uo=4", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music128/v4/79/89/24/7989243d-e7e1-7fae-81a0-d499aa2bb27e/886446809014.jpg/100x100bb.jpg", longDescription: "test"))
    }
}
