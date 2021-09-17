//
//  ReviewsDTOTests.swift
//  ApexReviewsModuleTests
//
//  Created by Olivier Rigault on 17/09/2021.
//

import XCTest
import Combine
@testable import ApexNetwork
@testable import ApexReviewsModule
@testable import ApexCore

class ReviewsDTOTests: XCTestCase {

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
                    "updated": {
                        "label": "2021-09-17T02:34:53-07:00"
                    },
                    "rights": {
                        "label": "Copyright 2008 Apple Inc."
                    },
                    "id": {
                        "label": "https://mzstoreservices-int-st.itunes.apple.com/gb/rss/customerreviews/id=436115342/mostrecent/json"
                    },
                    "title": {
                        "label": "iTunes Store: Customer Reviews"
                    },
                    "entry": [{
                            "author": {
                                "uri": {
                                    "label": "https://itunes.apple.com/gb/reviews/id309909880"
                                },
                                "name": {
                                    "label": "Katiebugk8"
                                },
                                "label": ""
                            },
                            "updated": {
                                "label": "2021-09-09T13:47:01-07:00"
                            },
                            "content": {
                                "label": "Have received cash back from Quidco but annoyingly not all cash back tracks, regardless of using a pc instead of the app",
                                "attributes": {
                                    "type": "text"
                                }
                            },
                            "id": {
                                "label": "7788861997"
                            },
                            "im:contentType": {
                                "attributes": {
                                    "label": "Application",
                                    "term": "Application"
                                }
                            },
                            "title": {
                                "label": "Good, but not all cash back tracks!!"
                            },
                            "im:voteCount": {
                                "label": "0"
                            },
                            "link": {
                                "attributes": {
                                    "rel": "related",
                                    "href": "https://itunes.apple.com/gb/review?id=436115342&type=Purple%20Software"
                                }
                            },
                            "im:version": {
                                "label": "6.4.1"
                            },
                            "im:rating": {
                                "label": "4"
                            },
                            "im:voteSum": {
                                "label": "0"
                            }
                        },
                        {
                            "author": {
                                "uri": {
                                    "label": "https://itunes.apple.com/gb/reviews/id268798801"
                                },
                                "name": {
                                    "label": "burniede"
                                },
                                "label": ""
                            },
                            "updated": {
                                "label": "2021-09-03T02:30:41-07:00"
                            },
                            "content": {
                                "label": "The best guaranteed cash back site is Quidco , never let me down unlike other cash back sites that don’t payout",
                                "attributes": {
                                    "type": "text"
                                }
                            },
                            "id": {
                                "label": "7765512695"
                            },
                            "im:contentType": {
                                "attributes": {
                                    "label": "Application",
                                    "term": "Application"
                                }
                            },
                            "title": {
                                "label": "Quidco"
                            },
                            "im:voteCount": {
                                "label": "0"
                            },
                            "link": {
                                "attributes": {
                                    "rel": "related",
                                    "href": "https://itunes.apple.com/gb/review?id=436115342&type=Purple%20Software"
                                }
                            },
                            "im:version": {
                                "label": "6.4.1"
                            },
                            "im:rating": {
                                "label": "5"
                            },
                            "im:voteSum": {
                                "label": "0"
                            }
                        },
                        {
                            "author": {
                                "uri": {
                                    "label": "https://itunes.apple.com/gb/reviews/id114451300"
                                },
                                "name": {
                                    "label": "Jcermann"
                                },
                                "label": ""
                            },
                            "updated": {
                                "label": "2021-03-17T11:28:50-07:00"
                            },
                            "content": {
                                "label": "Made some purchases from various companies payout no issues. Then used their own gas supply switch service and payment delayed by two months, customer service keep saying they are chasing the payment - from their own company? Trust broken.",
                                "attributes": {
                                    "type": "text"
                                }
                            },
                            "id": {
                                "label": "7113977936"
                            },
                            "im:contentType": {
                                "attributes": {
                                    "label": "Application",
                                    "term": "Application"
                                }
                            },
                            "title": {
                                "label": "Two months wait no payment"
                            },
                            "im:voteCount": {
                                "label": "0"
                            },
                            "link": {
                                "attributes": {
                                    "rel": "related",
                                    "href": "https://itunes.apple.com/gb/review?id=436115342&type=Purple%20Software"
                                }
                            },
                            "im:version": {
                                "label": "6.0.1"
                            },
                            "im:rating": {
                                "label": "1"
                            },
                            "im:voteSum": {
                                "label": "0"
                            }
                        }
                    ],
                    "link": [{
                            "attributes": {
                                "rel": "alternate",
                                "type": "text/html",
                                "href": "https://music.apple.com/WebObjects/MZStore.woa/wa/viewGrouping?cc=gb&id=130"
                            }
                        },
                        {
                            "attributes": {
                                "rel": "self",
                                "href": "https://mzstoreservices-int-st.itunes.apple.com/gb/rss/customerreviews/id=436115342/mostrecent/json"
                            }
                        },
                        {
                            "attributes": {
                                "rel": "first",
                                "href": "https://itunes.apple.com/gb/rss/customerreviews/page=1/id=436115342/sortby=mostrecent/xml?urlDesc=/customerreviews/id=436115342/mostrecent/json"
                            }
                        },
                        {
                            "attributes": {
                                "rel": "last",
                                "href": "https://itunes.apple.com/gb/rss/customerreviews/page=10/id=436115342/sortby=mostrecent/xml?urlDesc=/customerreviews/id=436115342/mostrecent/json"
                            }
                        },
                        {
                            "attributes": {
                                "rel": "previous",
                                "href": "https://itunes.apple.com/gb/rss/customerreviews/page=1/id=436115342/sortby=mostrecent/xml?urlDesc=/customerreviews/id=436115342/mostrecent/json"
                            }
                        },
                        {
                            "attributes": {
                                "rel": "next",
                                "href": "https://itunes.apple.com/gb/rss/customerreviews/page=2/id=436115342/sortby=mostrecent/xml?urlDesc=/customerreviews/id=436115342/mostrecent/json"
                            }
                        }
                    ],
                    "icon": {
                        "label": "http://itunes.apple.com/favicon.ico"
                    }
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
                let entry = reviews.feed.entry
                XCTAssertEqual(entry.count, 3)
                XCTAssertEqual(entry[2].title, "Two months wait no payment")
                XCTAssertEqual(entry[2].author, "Jcermann")
                XCTAssertEqual(entry[2].content, "Made some purchases from various companies payout no issues. Then used their own gas supply switch service and payment delayed by two months, customer service keep saying they are chasing the payment - from their own company? Trust broken.")
                XCTAssertEqual(entry[2].rating, "1")
                XCTAssertEqual(entry[2].version, "6.0.1")
                XCTAssertEqual(entry[2].updated.description, "2021-03-17 18:28:50 +0000")
                
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
                    XCTAssertEqual(error, expectedError)
                default:
                    XCTAssert(false, "Was expected an error, got a success instead")
                }
                
                expectation.fulfill()
            })
            { _ in }
        
        wait(for: [expectation], timeout: 1)
    }
}
