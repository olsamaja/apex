//
//  DetailsScreen.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 03/06/2024.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct DetailsScreen: View {

    private let model: DetailsViewModel

    public init(model: DetailsViewModel) {
        self.model = model
    }

    public var body: some View {
        List {
            ForEach(model.sections) { section in
                SectionRows(with: section)
                    .fixedSize(horizontal: false, vertical: true)
                    .listRowBackground(Color.clear)
                    .padding([.top, .bottom], 8)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    
    enum Constants {
        static let details = Details(trackId: 0,
                                     trackName: "Monzo - Mobile Banking",
                                     averageUserRating: 4.5,
                                     version: "1.2.3",
                                     minimumOsVersion: "13.0",
                                     description: "Join over 8 million customers who trust Monzo to see, save, and spend their money with confidence. \n\n\nMonzo is the smart way to take control of your personal finances. Our Mastercard debit card is designed to make your money work for you.\n\nMONZO ACCOUNT BENEFITS\n\nINDIVIDUAL AND JOINT ACCOUNTS: Manage money with a personal account or as a team with Joint Accounts. Get paid up to two days early when you add your Direct Deposit. \n\n\nAWARD-WINNING SUPPORT: Get real support from real people, fast. Our award-winning team is here to help you get the most out of Monzo 24x7!\n\n\nSEE YOUR FINANCES IN A NEW LIGHT: Manage all your money, no matter where it lives.  Link all your checking, savings, certificates of deposit, and credit cards from other providers, to see your full financial life with Trends. See the big picture in Monzo so you’re never left in the dark. \n\n\nSAVE EFFORTLESSLY: Save for what matters most with Pots.  Create Pots for monthly essential spending or to achieve your specific goals.  We’ll ensure you have enough money set aside automatically with each paycheck with Salary Sorter. Need to save even faster, you can turn on Round up payments and put spare change in a Pot instantly.\n\n\nSPEND CONFIDENTLY: Focus on having fun, not maintaining a budget.  Spend confidently on the Monzo card knowing exactly what is left-to-spend and hit your spending Target.  Stay in total control with instant notifications every time you pay for something, with a balance that updates immediately, not days later. Monzo even does the math to help you add a tip. \n\n\nSAY GOODBYE TO FEES: We don’t charge fees for spending on your card, we don’t charge overdraft fees and we don’t mark up the exchange rate when you go abroad.\n\n\nSEND AND RECEIVE MONEY WITH NO TRANSFER FEES: Pay and get paid in seconds for free, and start spending your money instantly.\n\n\nSTAY IN CONTROL: If you lose your card, freeze it in the app and get a new one quickly. (Or defrost it if you find it again.)\n\n\nDESIGNED TO TRAVEL WORRY-FREE: Use your card anywhere. Pay anywhere, in any currency, fee-free. Whether it's with your hot coral debit card, or Apple Pay, Monzo works all around the world, and you don’t need to tell us when you're going.\n\nSERIOUSLY SECURE: Money in your Monzo account is protected by FDIC, so you’re insured up to $250,000, and our anti-fraud systems make sure your money is safe, without adding friction for you.\nProtect your account with Touch ID, Face ID, fingerprint, or PIN.",
                                     sellerName: "Monzo Bank Limited",
                                     fileSizeBytes: 426137600,
                                     userRatingCount: 1208,
                                     releaseNotes: "Let's give a hand to all the engineers fixing bugs and doing general maintenance this week. It's the little things that help make our app what it is.",
                                     releaseDate: Date())
    }
    
    return DetailsScreen(model: DetailsViewModel(details: Constants.details))
}
