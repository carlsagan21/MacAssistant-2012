//
//  ClubLoader.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DatabaseTypes.h"
#import "GameVersions.h"
#import "FMDateLoader.h"
#import "ClubLoader.h"
#import "ClubFinanceLoader.h"
#import "ClubSponsorLoader.h"
#import "IDPCLoader.h"
#import "RegionalDivisionLoader.h"
#import "ScoutingKnowledgeLoader.h"
#import "ShortlistedPersonLoader.h"
#import "TeamContainerLoader.h"

@implementation Loader (ClubLoader)

+ (id)readClubFromData:(NSData *)data atOffset:(unsigned int *)byteOffset version:(short)version
{
	char cbuffer;
	short sbuffer;
	float fbuffer;
	int ibuffer;
	BOOL debug = YES;
	NSMutableArray *tempArray;
	
	unsigned int offset = *byteOffset;
	
	Club *object = [[Club alloc] init];
	
	// Unknown if Valid
    [data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setDatabaseClass:cbuffer];
	
    // Unknown if Valid
	if ([object databaseClass]==DBC_LEAGUE_BODY_CLUB)
	{
		[object setIsLeagueBodyClub:TRUE];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setCompetitionID:ibuffer];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setMaximumWeeklyWage:ibuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setAllowSponsorshipForTopPlayers:cbuffer];
	}
	
    // Unknown if Valid
    // Offsets:
    // FM 2011: 1377347
    // FM 2012: 1658871
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)];
    offset += 4;
	[object setNationID:ibuffer];
	
    // Unknown if Valid
    // Offsets:
    // FM 2011: 1377351
    // FM 2012: 1658875
    [data getBytes:&ibuffer range:NSMakeRange(offset, 4)];
    offset += 4;
	[object setCityID:ibuffer];
	
    // Unknown if Valid
    // Offsets:
    // FM 2011: 1377355
    // FM 2012: 1658879
    [data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setNickname1Gender:cbuffer];
	
    // Unknown if Valid
    // Offsets:
    // FM 2011: 1377356
    // FM 2012: 1658880
    [object setNickname1:[FMString readFromData:data atOffset:&offset]];
    // offset += 4;
    
    // Offsets:
    // FM 2011: 1377360
    // FM 2012: 1658884
    // Looks like we need to skip for FM 2012
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    // offset += 1;
	[object setNickname2Gender:cbuffer];
    
    // Offsets:
    // FM 2011: 1377361
    // FM 2012: 1658884
    // Looks like we need to skip for FM 2012
	// [object setNickname2:[FMString readFromData:data atOffset:&offset]];
    
    // Unknown if Valid
    // Offsets:
    // FM2011: 1377365
    // FM 2012: 1658884
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setYouthAcademy:cbuffer];
    
    // Offsets:
    // FM2011: 1377366
    // FM 2012: 1658885
    // Unknown if Valid
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setYouthSetup:cbuffer];
    
    // Offsets:
    //FM2011: 1377367
    //FM 2012: 1658886
    // Unknown if Valid
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setYouthRecruitment:cbuffer];
    
    // Offsets:
    //FM2011: 1377368
    //FM 2012: 1658887
    // Valid
	[data getBytes:&sbuffer range:NSMakeRange(offset, 2)];
    offset += 2;
	[object setYearFounded:sbuffer];
    
    // Unknown if Valid
    // Offsets:
    //FM2011: 1377370
    //FM 2012: 1658889
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)];
    offset += 4;
	[object setFutureTransferManagerID:ibuffer];
    
    // Unknown if Valid
    // Offsets:
    //FM2011: 1377374
    //FM 2012: 1658893
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setProfessionalStatus:cbuffer];
    
    // FM2012 has an extra 0x3 unknown bytes ???
    offset += 3;
    
    // Unknown if Valid
    // Offsets:
    //FM2011: 1377375
    //FM 2012: 1658897
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)];
    offset += 4;
	[object setAverageAttendance:ibuffer];
    
    // Unknown if Valid
    // Offsets:
    //FM2011: 1377379
    //FM 2012: 1658901
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)];
    offset += 4;
	[object setMinimumAttendance:ibuffer];
    
    // Unknown if Valid
    // Offsets:
    //FM2011: 1377383
    //FM 2012: 1658905
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)];
    offset += 4;
	[object setMaximumAttendance:ibuffer];
    
    // Unknown if Valid
    // Offsets:
    //FM2011: 1377387
    //FM 2012: 1658909
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setTrainingFacilities:cbuffer];
    
    // Unknown if Valid
    // Offsets:
    //FM2011: 1377388
    //FM 2012: 1658910
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setFlags:cbuffer];
    
	if ([object flags] > CF_MAX) { 
		return [NSString stringWithFormat:@"Invalid club flags - %d",[object flags]]; 
	}
	
	// ??
    // Offsets:
    //FM2011: 1377389
    //FM 2012: 1658911
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setUnknownChar1:cbuffer];
	
    // Temporarily go back 15 bytes for 2012
    offset -= 15;
    
    // Offsets:
    //FM2011: 1377390
    //FM 2012: 1658897
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)];
    offset += 4;
	[object setChairmanID:ibuffer];
    
    // Offsets:
    //FM2011: 1377394
    //FM 2012: 1658901
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setRoughFinancialState:cbuffer];
	
    // Offsets:
    //FM2011: 1377395
    //FM 2012: 1658902
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	[object setMorale:cbuffer];
	
    // Offsets:
    //FM2011: 1377396
    //FM 2012: 1658903
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	tempArray = [[NSMutableArray alloc] init];
	for (int i=0;i<cbuffer;i++) {
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)];
        offset += 4;
		[tempArray addObject:[NSNumber numberWithInt:ibuffer]];
	}
	[object setDirectors:tempArray];
	[tempArray release];
	
    // Offsets:
    //FM2011: 1377397
    //FM 2012: 1658904
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)];
    offset += 1;
	tempArray = [[NSMutableArray alloc] init];
	for (int i=0;i<cbuffer;i++) {
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)];
        offset += 4;
		[tempArray addObject:[NSNumber numberWithInt:ibuffer]];
	}
	[object setScouts:tempArray];
	[tempArray release];
	
	// here in man u 1 at 1462493
	// here in test2mls at 1595427
	
	if (debug) { NSLog(@"before finance at %d",offset); }
	
    // Offsets:
    //FM2011: 1377398
    //FM 2012: 1658905
	id finance = [ClubFinanceLoader readFromData:data atOffset:&offset version:version];
	if ([[finance className] isEqualToString:@"ClubFinance"]) {
		[object setFinance:finance];
	}
	else { return [NSString stringWithFormat:@"Finance - %@",finance]; }
	
	if (debug) { NSLog(@"after finance at %d",offset); }
	
    // Offsets:
    //FM2011: 1377465
    //FM 2012: 1658973
	[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	tempArray = [[NSMutableArray alloc] init];
	for (int i=0;i<sbuffer;i++) {
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[tempArray addObject:[NSNumber numberWithInt:ibuffer]];
	}
	[object setTransferOffers:tempArray];
	[tempArray release];
	
    // Offsets:
    //FM2011: 1377467
    //FM 2012: 1658975
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamStrengthRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamQuicknessRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamGoalkeepingRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamTacticsRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamBallControlRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamDefendingRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamAttackingRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamShootingRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamSetPiecesRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamStrengthWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamQuicknessWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamGoalkeepingWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamTacticsWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamBallControlWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamDefendingWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamAttackingWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamShootingWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setFirstTeamSetPiecesWorkload:cbuffer];
	
	// first team
    // Offsets:
    //FM2011: 1377485
    //FM 2012: NO JUMP
	// [object setUnknownData1:[data subdataWithRange:NSMakeRange(offset, 94)]]; offset += 94;
	
    // first team
    // Offsets:
    //FM2011: 1377579
	// [data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	// [object setUnknownShort1:sbuffer];
    
    // first team
    // Offsets:
    //FM2011: 1377581
	// [object setUnknownData2:[data subdataWithRange:NSMakeRange(offset, (sbuffer * 2))]]; offset += (sbuffer * 2);
	 
    // first team
    // Offsets:
    //FM2011: 1377583
    //FM 2012: 1658993
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamStrengthRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamQuicknessRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamGoalkeepingRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamTacticsRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamBallControlRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamDefendingRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamAttackingRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamShootingRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamSetPiecesRating:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamStrengthWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamQuicknessWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamGoalkeepingWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamTacticsWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamBallControlWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamDefendingWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamAttackingWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamShootingWorkload:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setYouthTeamSetPiecesWorkload:cbuffer];
	
    // Offsets:
    //FM2011: 1377601
    //FM 2012: 1659011
    
	// youth team
    // NOT NEEDED BY FM 2012
	// [object setUnknownData3:[data subdataWithRange:NSMakeRange(offset, 94)]]; offset += 94;
	
    // Offsets:
    //FM2011: 1377695
    // FM 2012: 1659011
	//[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	//[object setUnknownShort2:sbuffer];
    
    // Offsets:
    //FM2011: 1377697
    // FM 2012: 1659011
	// [object setUnknownData4:[data subdataWithRange:NSMakeRange(offset, (sbuffer * 2))]];  offset += (sbuffer * 2);
	
    // Offsets:
    //FM2011: 1377699
    // FM 2012: 1659011
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	tempArray = [[NSMutableArray alloc] init];
	for (int i=0;i<cbuffer;i++) {
		[tempArray addObject:[IDPCLoader readFromData:data atOffset:&offset]];
	}
	[object setIDPCs:tempArray];
	[tempArray release];
	
    // Offsets:
    //FM2011: 1377700
    // FM 2012: 1659012
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	tempArray = [[NSMutableArray alloc] init];
	for (int i=0;i<cbuffer;i++) {
		[tempArray addObject:[ClubSponsorLoader readFromData:data atOffset:&offset]];
	}
	[object setSponsors:tempArray];
	[tempArray release];
	
	if (debug) { NSLog(@"after sponsors at %d",offset); }
	
    // Offsets:
    //FM2011: 1377701
    // FM 2012: 1659013
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	tempArray = [[NSMutableArray alloc] init];
	for (int i=0;i<cbuffer;i++) {
		[tempArray addObject:[RegionalDivisionLoader readFromData:data atOffset:&offset]];
	}
	[object setRegionalDivisions:tempArray];
	[tempArray release];
	
	if (debug) { NSLog(@"after regionals at %d",offset); }
	
    // Offsets:
    //FM2011: 1377702
    // FM 2012: 1659014
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setHasUEFACoefficient:cbuffer];
	if ([object hasUEFACoefficient]) {
		
		[object setUnknownData5:[data subdataWithRange:NSMakeRange(offset, 4)]]; offset += 4; 
	
		/*
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUEFAPoints:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUEFAMatches:cbuffer];
		*/
		
		[data getBytes:&fbuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setUEFATempCoefficient:fbuffer];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setUEFA5YearTotal:ibuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		tempArray = [[NSMutableArray alloc] init];
		for (int i=0;i<cbuffer;i++) {
			[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
			[tempArray addObject:[NSNumber numberWithInt:ibuffer]];
		}
		[object setCoefficients:tempArray];
		[tempArray release];
	}
	
	if (debug) { NSLog(@"after coefficients at %d",offset); }
	
    // FM 2012: 1659015
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setHasScoutingKnowledges:cbuffer];
	if ([object hasScoutingKnowledges]) {
		if (debug) { NSLog(@"SKs at %d",offset); }
		
		// ???
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar2:cbuffer];
		
		[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
		tempArray = [[NSMutableArray alloc] init];
		for (int i=0;i<sbuffer;i++) {
			[tempArray addObject:[ScoutingKnowledgeLoader readFromData:data atOffset:&offset]];
		}
		[object setScoutingKnowledges:tempArray];
		[tempArray release];
	}
	
	if (debug) { NSLog(@"after sks at %d",offset); }
	
	// ???
    // FM 2012: 1659016
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar3:cbuffer];
    
    // FM 2012: 1659017
    [data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	// [object setUnknownChar4:cbuffer];
	
    // FM 2012: 1659018
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setSeasonTicketHolders:ibuffer];
    
    // FM 2012: 1659022
	[object setSeasonEndDate:[FMDateLoader readFromData:data atOffset:&offset]];
    
    // FM 2012: 1659026
	[object setPreSeasonStartDate:[FMDateLoader readFromData:data atOffset:&offset]];
    
    // FM 2012: 1659030
	[object setSeasonStartDate:[FMDateLoader readFromData:data atOffset:&offset]];
	
	// ???
    // FM 2012: 1659034
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar4:cbuffer];
    
    // FM 2012: 1659035
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar5:cbuffer];
    
    // FM 2012: 1659036
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar6:cbuffer];
	
    // FM 2012: 1659037
	[object setUnknownDate1:[FMDateLoader readFromData:data atOffset:&offset]];
	
    // FM 2012: 1659041
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar7:cbuffer];
	
    // FM 2012: 1659042
    // FM 2012: 26 unknown bytes
    offset += 26;
    
    // FM 2012: 1659068
	[object setUnknownDate2:[FMDateLoader readFromData:data atOffset:&offset]];
	
    // FM 2012: 1659072
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar8:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar9:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar10:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar11:cbuffer];
	
    // FM 2012: 1659076
	// ???
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar12:cbuffer];
    
    // FM 2012: 1659077
	//[object setUnknownData6:[data subdataWithRange:NSMakeRange(offset, (cbuffer*13))]]; offset += (cbuffer*13);
	
    // FM 2012 Skip 5 bytes
    offset += 5;
    
	if (debug) { NSLog(@"before TC at %d",offset); }
	
	id tc = [TeamContainerLoader readFromData:data atOffset:&offset];
	if ([[tc className] isEqualToString:@"TeamContainer"]) {
		[object setTeamContainer:tc];
	}
	else { return [NSString stringWithFormat:@"Team Container - %@",tc]; }
	
	if (debug) { NSLog(@"after TC at %d",offset); }
    
    // FM 2012
    // Skip 10 bytes of unknown data
    offset += 14;
    
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setRowID:ibuffer];
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setUID:ibuffer];
	
	if (debug) { NSLog(@"Club %d (%@) at %d",[object rowID],[[object teamContainer] name],offset); }
    
    // FM 2012: Skip 4 bytes at the end of the file
    offset += 4;
	
	*byteOffset = offset;
	
	return object;
}



@end
