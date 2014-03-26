//
//  CCAnalyserFarm.h
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCAnalyser;

@interface CCAnalyserFarm : NSObject

@property (nonatomic, strong) NSArray *analysers;

- (void)updateAnalysers;
- (CCAnalyser *)bestAnalyser;

@end
