//
//  ViewController.m
//  switchConfetti
//
//  Created by valentinkovalski on 12/27/16.
//  Copyright © 2016 valentinkovalski. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *labelCounter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:227.f/255.f green:235.f/255.f blue:245.f/255.f alpha:1.0];
    self.sceneView.backgroundColor = [UIColor clearColor];
    self.title = @"Switch Confetti";
    [self setupTimer];
 }

- (void)setupTimer {
    self.labelCounter.text = @"0";
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSUInteger counter = [self.labelCounter.text integerValue];
        self.labelCounter.text = [NSString stringWithFormat:@"%lu", ++counter];
        if(counter == 3) {
            [self.timer invalidate];
            [self blast];
            self.labelCounter.text = @"action";
        }
    }];
}


- (void)blast {
    SCNScene *scene = [SCNScene new];
    SCNNode *particlesNode = [SCNNode new];
    particlesNode.position = SCNVector3Make(0, 2, 0);
    
    //    SCNNode *particlesNodeExplosion = [SCNNode new];
    //    particlesNodeExplosion.position = SCNVector3Make(0, 1.3, 0);
    //
    //    SCNParticleSystem *particleSystemExplosion = [SCNParticleSystem particleSystemNamed:@"confetti_explosion" inDirectory:@""];
    //    [particlesNodeExplosion addParticleSystem:particleSystemExplosion];
    
    SCNParticleSystem *particleSystem = [SCNParticleSystem particleSystemNamed:@"confetti_rectangle" inDirectory:@""];
    [particlesNode addParticleSystem:particleSystem];
    
    SCNParticleSystem *particleSystem2 = [SCNParticleSystem particleSystemNamed:@"confetti_circle" inDirectory:@""];
    [particlesNode addParticleSystem:particleSystem2];
    
    
    //[scene.rootNode addChildNode:particlesNodeExplosion];
    [scene.rootNode addChildNode:particlesNode];
    
    self.sceneView.scene = scene;
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf setupTimer];
    });
}


@end
