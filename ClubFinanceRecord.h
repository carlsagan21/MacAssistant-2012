//
//  ClubFinanceRecord.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/14.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ClubFinanceRecord : NSObject {
	int		otherOut, loanRepayments, leagueFines, groundMaintenance, playerWages, staffWages,
			dividendsOut, bonuses, signingOnFees, playersBought, tax, matchDayExpenses, gateReceipts,
			otherIn, prizeMoney, seasonTickets, interest, investments, TVRevenue, merchandising,
			playersSold, sponsorship, renewalSigningOnFees, grants, nonFootballCosts,
			fundRaising, unknownInt1, matchDayIncome;
}

@property (assign, readwrite) int otherOut, loanRepayments, leagueFines, groundMaintenance, playerWages, staffWages,
dividendsOut, bonuses, signingOnFees, playersBought, tax, matchDayExpenses, gateReceipts,
otherIn, prizeMoney, seasonTickets, interest, investments, TVRevenue, merchandising,
playersSold, sponsorship, renewalSigningOnFees, grants, nonFootballCosts, fundRaising, unknownInt1,
matchDayIncome;

@end
