//
//  MediaRow.swift
//  CaudalieTestSwiftUI
//
//  Created by Sébastien Rochelet on 06/06/2023.
//

import SwiftUI

struct MediaRow: View {
    var media: Media
    
    var body: some View {
        HStack {
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
            Text(media.trackName ?? "")
            Text(media.artistName ?? "")
            Spacer()
        }
    }
}

struct MediaRow_Previews: PreviewProvider {
    static var previews: some View {
        MediaRow(media: Media(artistName: "test", collectionName: "test", trackName: "test", trackViewUrl: "https://music.apple.com/us/album/nel-sole-live/1310669695?i=1310670411&uo=4", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music128/v4/79/89/24/7989243d-e7e1-7fae-81a0-d499aa2bb27e/886446809014.jpg/100x100bb.jpg", longDescription: "test"))
    }
}
