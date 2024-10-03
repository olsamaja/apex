//
//  ReviewsDTOTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 02/11/2023.
//

import XCTest
import Combine
import Testing
@testable import ApexCore
@testable import ApexViewModule

final class ReviewsDTOTests: XCTestCase {
    
    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }
    
    enum Constants {
        static let jsonString = """
            {
                "feed": {
                    "author": {
                        "name": {
                            "label": "iTunes Store"
                        },
                        "uri": {
                            "label": "http://www.apple.com/uk/itunes/"
                        }
                    },
                    "entry": [
                        {
                            "author": {
                                "uri": {
                                    "label": "https://itunes.apple.com/gb/reviews/id1270430290"
                                },
                                "name": {
                                    "label": "Jay007andrews"
                                },
                                "label": ""
                            },
                            "updated": {
                                "label": "2023-10-31T11:42:44-07:00"
                            },
                            "im:rating": {
                                "label": "5"
                            },
                            "im:version": {
                                "label": "5.47.0"
                            },
                            "id": {
                                "label": "10535898992"
                            },
                            "title": {
                                "label": "Great"
                            },
                            "content": {
                                "label": "Easy to get in touch with the call centre after a nightmare of a day ha. Thanks Andrea. 🙂",
                                "attributes": {
                                    "type": "text"
                                }
                            },
                            "link": {
                                "attributes": {
                                    "rel": "related",
                                    "href": "https://itunes.apple.com/gb/review?id=1052238659&type=Purple%20Software"
                                }
                            },
                            "im:voteSum": {
                                "label": "0"
                            },
                            "im:contentType": {
                                "attributes": {
                                    "term": "Application",
                                    "label": "Application"
                                }
                            },
                            "im:voteCount": {
                                "label": "0"
                            }
                        },
                        {
                            "author": {
                                "uri": {
                                    "label": "https://itunes.apple.com/gb/reviews/id929984050"
                                },
                                "name": {
                                    "label": "lannas77"
                                },
                                "label": ""
                            },
                            "updated": {
                                "label": "2023-10-31T10:23:24-07:00"
                            },
                            "im:rating": {
                                "label": "4"
                            },
                            "im:version": {
                                "label": "5.47.0"
                            },
                            "id": {
                                "label": "10535705656"
                            },
                            "title": {
                                "label": "Great app"
                            },
                            "content": {
                                "label": "Best banking app ever. So simple to use",
                                "attributes": {
                                    "type": "text"
                                }
                            },
                            "link": {
                                "attributes": {
                                    "rel": "related",
                                    "href": "https://itunes.apple.com/gb/review?id=1052238659&type=Purple%20Software"
                                }
                            },
                            "im:voteSum": {
                                "label": "0"
                            },
                            "im:contentType": {
                                "attributes": {
                                    "term": "Application",
                                    "label": "Application"
                                }
                            },
                            "im:voteCount": {
                                "label": "0"
                            }
                        }
                    ],
                    "link" : [
                      {
                        "attributes" : {
                          "rel" : "alternate",
                          "type" : "text/html",
                          "href" : "https://music.apple.com/WebObjects/MZStore.woa/wa/viewGrouping?cc=gb&id=130"
                        }
                      },
                      {
                        "attributes" : {
                          "rel" : "self",
                          "href" : "https://mzstoreservices-int-st.itunes.apple.com/gb/rss/customerreviews/id=1052238659/mostrecent/json"
                        }
                      },
                      {
                        "attributes" : {
                          "rel" : "first",
                          "href" : "https://itunes.apple.com/gb/rss/customerreviews/page=1/id=1052238659/sortby=mostrecent/xml?urlDesc=/customerreviews/id=1052238659/mostrecent/json"
                        }
                      },
                      {
                        "attributes" : {
                          "rel" : "last",
                          "href" : "https://itunes.apple.com/gb/rss/customerreviews/page=10/id=1052238659/sortby=mostrecent/xml?urlDesc=/customerreviews/id=1052238659/mostrecent/json"
                        }
                      },
                      {
                        "attributes" : {
                          "rel" : "previous",
                          "href" : "https://itunes.apple.com/gb/rss/customerreviews/page=1/id=1052238659/sortby=mostrecent/xml?urlDesc=/customerreviews/id=1052238659/mostrecent/json"
                        }
                      },
                      {
                        "attributes" : {
                          "rel" : "next",
                          "href" : "https://itunes.apple.com/gb/rss/customerreviews/page=2/id=1052238659/sortby=mostrecent/xml?urlDesc=/customerreviews/id=1052238659/mostrecent/json"
                        }
                      }
                    ]
                }
            }
            """
    }

    func testReviewsDTOSuccessful() throws {

        let expectation = XCTestExpectation(description: "Decoding ReviewsDTO")
        let publisher: AnyPublisher<ReviewsDTO, DataError> = Constants.jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { reviews in
                XCTAssertEqual(reviews.feed.entry.count, 2)
                XCTAssertEqual(reviews.feed.entry[1].title, "Great app")
                XCTAssertEqual(reviews.feed.link.count, 6)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testReviewsDTOInvalid() {
        let expectation = XCTestExpectation(description: "Decoding invalid ReviewsDTO")
        let publisher: AnyPublisher<ReviewsDTO, DataError> = "invalid dto".parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    let expectedError = ApexCore.DataError.parsing(description: "The data couldn’t be read because it isn’t in the correct format.")
                    #expect(error == expectedError)
                default:
                    #expect(Bool(false), "Was expected an error, got a success instead")
                }
                
                expectation.fulfill()
            })
            { _ in }
        
        wait(for: [expectation], timeout: 1)
    }

}
