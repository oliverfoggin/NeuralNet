//
//  CCController.m
//  NeuralNet
//
//  Created by Oliver Foggin on 26/03/2014.
//  Copyright (c) 2014 ClicksCo. All rights reserved.
//

#import "CCController.h"

#import "CCAnalyser.h"
#import "CCNeuralNet.h"

@interface CCController ()

@property (nonatomic, strong) CCAnalyser *analyser;

@property (weak) IBOutlet NSButton *button1;
@property (weak) IBOutlet NSButton *button2;
@property (weak) IBOutlet NSButton *button3;
@property (weak) IBOutlet NSButton *button4;
@property (weak) IBOutlet NSButton *button5;
@property (weak) IBOutlet NSButton *button6;
@property (weak) IBOutlet NSButton *button7;
@property (weak) IBOutlet NSButton *button8;

@property (weak) IBOutlet NSTextField *resultLabel;

@end

@implementation CCController

- (void)awakeFromNib
{
    self.analyser = [[CCAnalyser alloc] init];
    [self.analyser.brain setWeights:[[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brain" ofType:@"plist"]]];
}

- (IBAction)analyseInput:(id)sender
{
//    NSMutableArray *inputs = [NSMutableArray array];
//    
//    [inputs addObject:self.button1.state == NSOnState ? @1 : @0];
//    [inputs addObject:self.button2.state == NSOnState ? @1 : @0];
//    [inputs addObject:self.button3.state == NSOnState ? @1 : @0];
//    [inputs addObject:self.button4.state == NSOnState ? @1 : @0];
//    [inputs addObject:self.button5.state == NSOnState ? @1 : @0];
//    [inputs addObject:self.button6.state == NSOnState ? @1 : @0];
//    [inputs addObject:self.button7.state == NSOnState ? @1 : @0];
//    [inputs addObject:self.button8.state == NSOnState ? @1 : @0];
//    
//    NSArray *output = [self.analyser analysePixelInput:inputs];
//    
//    if (output && output.count >= 1) {
//        NSNumber *result = output[0];
//        
//        if ([result isEqualToNumber:@1]) {
//            [self.resultLabel setStringValue:@"This is a 4"];
//        } else {
//            [self.resultLabel setStringValue:@"This is not a 4"];
//        }
//    }
    
    NSLog(@"Starting");
    
    NSInteger countOfYes = 0;
    NSInteger totalCount = 0;
    NSMutableArray *positives = [NSMutableArray array];
    
    for (int a=0; a<2; ++a) {
        for (int b=0; b<2; ++b) {
            for (int c=0; c<2; ++c) {
                for (int d=0; d<2; ++d) {
                    for (int e=0; e<2; ++e) {
                        for (int f=0; f<2; ++f) {
                            for (int g=0; g<2; ++g) {
                                for (int h=0; h<2; ++h) {
                                    NSArray *inputs = @[@(a),@(b),@(c),@(d),@(e),@(f),@(g),@(h)];
                                    
                                    NSNumber *result = [[self.analyser analysePixelInput:inputs] firstObject];
                                    
                                    if ([result isEqualToNumber:@1]) {
                                        [positives addObject:inputs];
                                        ++countOfYes;
                                    }
                                    ++totalCount;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    NSLog(@"Total Count: %ld", (long)totalCount);
    NSLog(@"Yes Count: %ld", (long)countOfYes);
    NSLog(@"Positives: %@", positives);
}

@end
