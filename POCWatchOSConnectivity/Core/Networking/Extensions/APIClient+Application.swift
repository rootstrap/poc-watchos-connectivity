//
//  Constaints.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 06/9/22.
//

import RSSwiftNetworking
import RSSwiftNetworkingAlamofire

typealias Response<T: Decodable> = (result:Result<T?, Error>, header: [AnyHashable: Any])

/// Provides an easy-access APIClient implementation to use across the application
/// You can define and configure as many APIClients as needed
internal class iOSBaseAPIClient {
  
  static let shared = iOSBaseAPIClient()
  private let apiClient: APIClient
  
  init(apiClient: APIClient = BaseAPIClient(
    networkProvider: AlamofireNetworkProvider(),
    headersProvider: RailsAPIHeadersProvider(sessionProvider: SessionHeadersProvider())
  )) {
    self.apiClient = apiClient
  }
  
  /// This is a wrapper to use concurrency. It should be deleted when RSSwiftNetworking library support concurrency
  /// https://github.com/rootstrap/RSSwiftNetworking/issues/3
  func request<T: Decodable>(endpoint: Endpoint) async throws -> Response<T> {
    try await withCheckedThrowingContinuation { continuation in
      apiClient.request(endpoint: endpoint) {
        (result: Result<T?, Error>, responseHeaders: [AnyHashable: Any])  in
        switch result {
        case .success(_):
          continuation.resume(returning: (result, responseHeaders))
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  /// This is a wrapper to use concurrency. It should be deleted when RSSwiftNetworking library support concurrency
  /// https://github.com/rootstrap/RSSwiftNetworking/issues/3
  func multipartRequest<T: Decodable>(
    endpoint: Endpoint,
    paramsRootKey: String,
    media: [MultipartMedia]
  ) async throws -> Response<T> {
    try await withCheckedThrowingContinuation { continuation in
      apiClient.multipartRequest(endpoint: endpoint, paramsRootKey: paramsRootKey, media:media) {
        (result: Result<T?, Error>, responseHeaders: [AnyHashable: Any])  in
        switch result {
        case .success(_):
          continuation.resume(returning: (result, responseHeaders))
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
