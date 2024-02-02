//
//  DiceBearNetwork.swift
//  APIRestDemo
//
//  Created by Adrian Iraizos Mendoza on 24/1/24.
//

import UIKit

final class DiceBearNetwork {
    static let shared = DiceBearNetwork()
    
    var urls: URLLocator
    var urlProtocol: URLProtocol.Type?
    var session: URLSession {
        if let urlProtocol {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [urlProtocol]
            return URLSession(configuration: configuration)
        } else {
            return URLSession.shared
        }
    }
    
    init(urlProtocol: URLProtocol.Type? = nil, urls: URLLocator = URLProduction()) {
        self.urlProtocol = urlProtocol
        self.urls = urls
    }
    
    func getFunEmoji() async throws -> UIImage {
        try await fetchImage(url: DiceBearModel.funEmoji.url, session: session)
    }
    
    func getEmojiWithOptions(_ model: DiceBearModel) async throws -> UIImage {
        try await fetchImage(url: DiceBearModel(
            funEmojiWithBackgroundColor: model.backgroundColor,
            backgroundType: model.backgroundType,
            eyes: model.eyes,
            mouth: model.mouth).url, session: session)
    }
}

