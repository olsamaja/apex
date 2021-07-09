//
//  MockURLProtocol.swift
//  ApexNetwork
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import ApexCore

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data) )?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func stopLoading() {}
    
    override func startLoading() {
         guard let handler = MockURLProtocol.requestHandler else {
            return
        }
        
        do {
            let (response, data)  = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch  {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
}

extension MockURLProtocol {
    
    static func makeInvalidRequestHandler() -> ((URLRequest) throws -> (HTTPURLResponse, Data))? {

        return { _ in
            throw DataError.invalidResponse
        }
    }

    static func makeRequestHandler(with jsonString: String) -> ((URLRequest) throws -> (HTTPURLResponse, Data))? {
        
        guard let data = jsonString.data(using: .utf8) else {
            OLLogger.info("Unable to convert string:\n \(jsonString)")
            return nil
        }
        
        return { request in
            guard let url = request.url else {
                throw DataError.invalidRequest
            }
            
            guard let response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: "2.0", headerFields: nil) else {
                throw DataError.invalidResponse
            }
            
            return (response, data)
        }
    }
        
    static func makeRequestHandler(in bundle: Bundle, with jsonFile: String) -> ((URLRequest) throws -> (HTTPURLResponse, Data))? {
        
        guard let contents = bundle.loadContents(of: jsonFile, ofType: "json") else {
            OLLogger.info("Unable to load contents of \(jsonFile).json")
            return nil
        }
        
        return makeRequestHandler(with: contents)
    }
    
}
