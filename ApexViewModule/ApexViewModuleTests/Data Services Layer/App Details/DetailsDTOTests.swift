//
//  DetailsDTOTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 02/11/2023.
//

import XCTest
import Combine
import Testing
@testable import ApexCore
@testable import ApexViewModule

final class DetailsDTOTests: XCTestCase {
    
    private var cancellable: AnyCancellable?

    override func tearDown() {
        cancellable?.cancel()
    }
    
    enum Constants {
        static let jsonString = """
            {
                "resultCount": 1,
                "results": [
                    {
                        "advisories": [],
                        "supportedDevices": [
                            "iPhone5s-iPhone5s",
                            "iPadAir-iPadAir",
                            "iPadAirCellular-iPadAirCellular",
                            "iPadMiniRetina-iPadMiniRetina",
                            "iPadMiniRetinaCellular-iPadMiniRetinaCellular",
                            "iPhone6-iPhone6",
                            "iPhone6Plus-iPhone6Plus",
                            "iPadAir2-iPadAir2",
                            "iPadAir2Cellular-iPadAir2Cellular",
                            "iPadMini3-iPadMini3",
                            "iPadMini3Cellular-iPadMini3Cellular",
                            "iPodTouchSixthGen-iPodTouchSixthGen",
                            "iPhone6s-iPhone6s",
                            "iPhone6sPlus-iPhone6sPlus",
                            "iPadMini4-iPadMini4",
                            "iPadMini4Cellular-iPadMini4Cellular",
                            "iPadPro-iPadPro",
                            "iPadProCellular-iPadProCellular",
                            "iPadPro97-iPadPro97",
                            "iPadPro97Cellular-iPadPro97Cellular",
                            "iPhoneSE-iPhoneSE",
                            "iPhone7-iPhone7",
                            "iPhone7Plus-iPhone7Plus",
                            "iPad611-iPad611",
                            "iPad612-iPad612",
                            "iPad71-iPad71",
                            "iPad72-iPad72",
                            "iPad73-iPad73",
                            "iPad74-iPad74",
                            "iPhone8-iPhone8",
                            "iPhone8Plus-iPhone8Plus",
                            "iPhoneX-iPhoneX",
                            "iPad75-iPad75",
                            "iPad76-iPad76",
                            "iPhoneXS-iPhoneXS",
                            "iPhoneXSMax-iPhoneXSMax",
                            "iPhoneXR-iPhoneXR",
                            "iPad812-iPad812",
                            "iPad834-iPad834",
                            "iPad856-iPad856",
                            "iPad878-iPad878",
                            "iPadMini5-iPadMini5",
                            "iPadMini5Cellular-iPadMini5Cellular",
                            "iPadAir3-iPadAir3",
                            "iPadAir3Cellular-iPadAir3Cellular",
                            "iPodTouchSeventhGen-iPodTouchSeventhGen",
                            "iPhone11-iPhone11",
                            "iPhone11Pro-iPhone11Pro",
                            "iPadSeventhGen-iPadSeventhGen",
                            "iPadSeventhGenCellular-iPadSeventhGenCellular",
                            "iPhone11ProMax-iPhone11ProMax",
                            "iPhoneSESecondGen-iPhoneSESecondGen",
                            "iPadProSecondGen-iPadProSecondGen",
                            "iPadProSecondGenCellular-iPadProSecondGenCellular",
                            "iPadProFourthGen-iPadProFourthGen",
                            "iPadProFourthGenCellular-iPadProFourthGenCellular",
                            "iPhone12Mini-iPhone12Mini",
                            "iPhone12-iPhone12",
                            "iPhone12Pro-iPhone12Pro",
                            "iPhone12ProMax-iPhone12ProMax",
                            "iPadAir4-iPadAir4",
                            "iPadAir4Cellular-iPadAir4Cellular",
                            "iPadEighthGen-iPadEighthGen",
                            "iPadEighthGenCellular-iPadEighthGenCellular",
                            "iPadProThirdGen-iPadProThirdGen",
                            "iPadProThirdGenCellular-iPadProThirdGenCellular",
                            "iPadProFifthGen-iPadProFifthGen",
                            "iPadProFifthGenCellular-iPadProFifthGenCellular",
                            "iPhone13Pro-iPhone13Pro",
                            "iPhone13ProMax-iPhone13ProMax",
                            "iPhone13Mini-iPhone13Mini",
                            "iPhone13-iPhone13",
                            "iPadMiniSixthGen-iPadMiniSixthGen",
                            "iPadMiniSixthGenCellular-iPadMiniSixthGenCellular",
                            "iPadNinthGen-iPadNinthGen",
                            "iPadNinthGenCellular-iPadNinthGenCellular",
                            "iPhoneSEThirdGen-iPhoneSEThirdGen",
                            "iPadAirFifthGen-iPadAirFifthGen",
                            "iPadAirFifthGenCellular-iPadAirFifthGenCellular",
                            "iPhone14-iPhone14",
                            "iPhone14Plus-iPhone14Plus",
                            "iPhone14Pro-iPhone14Pro",
                            "iPhone14ProMax-iPhone14ProMax",
                            "iPadTenthGen-iPadTenthGen",
                            "iPadTenthGenCellular-iPadTenthGenCellular",
                            "iPadPro11FourthGen-iPadPro11FourthGen",
                            "iPadPro11FourthGenCellular-iPadPro11FourthGenCellular",
                            "iPadProSixthGen-iPadProSixthGen",
                            "iPadProSixthGenCellular-iPadProSixthGenCellular",
                            "iPhone15-iPhone15",
                            "iPhone15Plus-iPhone15Plus",
                            "iPhone15Pro-iPhone15Pro",
                            "iPhone15ProMax-iPhone15ProMax"
                        ],
                        "features": [],
                        "isGameCenterEnabled": false,
                        "screenshotUrls": [
                            "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/8a/1f/53/8a1f53a9-31bb-d6a4-f09f-a4057b3d98c7/bacb4797-6d91-497a-aa9b-301ec36ed238_1_App_Store_9x16.jpg/392x696bb.jpg",
                            "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/cd/43/69/cd436992-651e-cfb7-58f2-94160ab99ce1/a0654f8d-bf37-470d-8b39-9deebdbc667c_2_App_Store_9x16.jpg/392x696bb.jpg",
                            "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/5f/b3/2d/5fb32d01-5a5d-3e37-bb5f-c3c27f4921c5/5210b0d8-ef54-4039-9892-3e6e1eab741d_3_App_Store_9x16.jpg/392x696bb.jpg",
                            "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/4e/d9/08/4ed90866-1475-d60a-7a74-439f97d78775/546d547d-8881-44c4-b22f-1252b169bcfa_4_App_Store_9x16.jpg/392x696bb.jpg",
                            "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/2d/d4/5a/2dd45a2b-08bf-8b42-0df3-59095d8f39b9/9bee61e8-9688-40f1-a7c7-bc151746515f_5_App_Store_9x16.jpg/392x696bb.jpg",
                            "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/ca/93/22/ca93226c-9eac-a113-3887-85ed629e78f8/4fc8c499-972d-4153-858b-0b834a76be3a_6_App_Store_9x16.jpg/392x696bb.jpg",
                            "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/56/7b/e4/567be42b-a70c-526d-5063-d8022cb6cbfc/644f28c0-9f3c-4be7-8cec-9b6ea200c9c4_7_App_Store_9x16.jpg/392x696bb.jpg",
                            "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/30/3d/a7/303da77a-a2df-9418-dbbb-f0f6f92c24b9/97df22f2-8c3a-4e1c-bfd0-40884d1c211b_8_App_Store_9x16.jpg/392x696bb.jpg",
                            "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/ca/76/68/ca7668e9-b8ae-6f66-fad0-31d2f13cd9a4/5fc66c2d-59b5-4fd9-a6ea-da3b224d2cce_9_App_Store_9x16.jpg/392x696bb.jpg"
                        ],
                        "ipadScreenshotUrls": [],
                        "appletvScreenshotUrls": [],
                        "artworkUrl60": "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/eb/e7/dd/ebe7dd83-5476-30dd-477d-f80a3554fa3a/AppIconProd-0-1x_U007emarketing-0-5-0-sRGB-85-220.png/60x60bb.jpg",
                        "artworkUrl512": "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/eb/e7/dd/ebe7dd83-5476-30dd-477d-f80a3554fa3a/AppIconProd-0-1x_U007emarketing-0-5-0-sRGB-85-220.png/512x512bb.jpg",
                        "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/eb/e7/dd/ebe7dd83-5476-30dd-477d-f80a3554fa3a/AppIconProd-0-1x_U007emarketing-0-5-0-sRGB-85-220.png/100x100bb.jpg",
                        "artistViewUrl": "https://apps.apple.com/us/developer/monzo-bank-limited/id995273047?uo=4",
                        "kind": "software",
                        "currentVersionReleaseDate": "2023-10-30T11:35:32Z",
                        "minimumOsVersion": "13.0",
                        "artistId": 995273047,
                        "artistName": "Monzo Bank Limited",
                        "genres": [
                            "Finance"
                        ],
                        "price": 0,
                        "description": "Join over 8 million customers who trust Monzo to see, save, and spend their money with confidence. \n\n\nMonzo is the smart way to take control of your personal finances. Our Mastercard debit card is designed to make your money work for you.\n\nMONZO ACCOUNT BENEFITS\n\nINDIVIDUAL AND JOINT ACCOUNTS: Manage money with a personal account or as a team with Joint Accounts. Get paid up to two days early when you add your Direct Deposit. \n\n\nAWARD-WINNING SUPPORT: Get real support from real people, fast. Our award-winning team is here to help you get the most out of Monzo 24x7!\n\n\nSEE YOUR FINANCES IN A NEW LIGHT: Manage all your money, no matter where it lives.  Link all your checking, savings, certificates of deposit, and credit cards from other providers, to see your full financial life with Trends. See the big picture in Monzo so you’re never left in the dark. \n\n\nSAVE EFFORTLESSLY: Save for what matters most with Pots.  Create Pots for monthly essential spending or to achieve your specific goals.  We’ll ensure you have enough money set aside automatically with each paycheck with Salary Sorter. Need to save even faster, you can turn on Round up payments and put spare change in a Pot instantly.\n\n\nSPEND CONFIDENTLY: Focus on having fun, not maintaining a budget.  Spend confidently on the Monzo card knowing exactly what is left-to-spend and hit your spending Target.  Stay in total control with instant notifications every time you pay for something, with a balance that updates immediately, not days later. Monzo even does the math to help you add a tip. \n\n\nSAY GOODBYE TO FEES: We don’t charge fees for spending on your card, we don’t charge overdraft fees and we don’t mark up the exchange rate when you go abroad.\n\n\nSEND AND RECEIVE MONEY WITH NO TRANSFER FEES: Pay and get paid in seconds for free, and start spending your money instantly.\n\n\nSTAY IN CONTROL: If you lose your card, freeze it in the app and get a new one quickly. (Or defrost it if you find it again.)\n\n\nDESIGNED TO TRAVEL WORRY-FREE: Use your card anywhere. Pay anywhere, in any currency, fee-free. Whether it's with your hot coral debit card, or Apple Pay, Monzo works all around the world, and you don’t need to tell us when you're going.\n\nSERIOUSLY SECURE: Money in your Monzo account is protected by FDIC, so you’re insured up to $250,000, and our anti-fraud systems make sure your money is safe, without adding friction for you.\nProtect your account with Touch ID, Face ID, fingerprint, or PIN.",
                        "currency": "USD",
                        "releaseDate": "2016-02-04T15:43:22Z",
                        "isVppDeviceBasedLicensingEnabled": true,
                        "sellerName": "Monzo Bank Limited",
                        "bundleId": "io.b2a.BankProd",
                        "genreIds": [
                            "6015"
                        ],
                        "trackId": 1052238659,
                        "trackName": "Monzo - Mobile Banking",
                        "primaryGenreName": "Finance",
                        "primaryGenreId": 6015,
                        "releaseNotes": "Let's give a hand to all the engineers fixing bugs and doing general maintenance this week. It's the little things that help make our app what it is.",
                        "trackCensoredName": "Monzo - Mobile Banking",
                        "languageCodesISO2A": [
                            "EN"
                        ],
                        "fileSizeBytes": "426137600",
                        "sellerUrl": "https://monzo.com/usa/",
                        "formattedPrice": "Free",
                        "contentAdvisoryRating": "4+",
                        "averageUserRatingForCurrentVersion": 4.62679,
                        "userRatingCountForCurrentVersion": 1187,
                        "averageUserRating": 4.62679,
                        "trackViewUrl": "https://apps.apple.com/us/app/monzo-mobile-banking/id1052238659?uo=4",
                        "trackContentRating": "4+",
                        "version": "5.47.0",
                        "wrapperType": "software",
                        "userRatingCount": 1187
                    }
                ]
            }
            """
    }

    func testDetailsDTOSuccessful() throws {

        let expectation = XCTestExpectation(description: "Decoding DetailsDTO")
        let publisher: AnyPublisher<DetailsDTO, DataError> = Constants.jsonString.parse()

        cancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in })
            { details in
                #expect(details.trackName == "Monzo - Mobile Banking")
                #expect(details.averageUserRating == 4.62679)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testDetailsDTOInvalid() {
        let expectation = XCTestExpectation(description: "Decoding invalid DetailsDTO")
        let publisher: AnyPublisher<DetailsDTO, DataError> = "invalid dto".parse()

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
