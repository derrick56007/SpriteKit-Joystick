//
//  Joystick.m
//  Joystick
//
//  Created by Derrick Liu on 8/6/13.
//  Copyright (c) 2013 TheSneakyNarwhal. All rights reserved.
//

#import "Joystick.h"

#define kThumbSpringBackDuration .3
@interface Joystick (Private)
-(void)resetVelocity;
-(CGPoint) anchorPointInPoints;

@end

@implementation Joystick

@synthesize velocity, angularVelocity;

-(CGPoint) anchorPointInPoints
{
    return  CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}

-(id)initWithThumb:(SKSpriteNode *)aNode
{
    if (self = [super init])
    {
        [self setUserInteractionEnabled:YES];
        velocity = CGPointZero;
        thumbNode = aNode;
        [self addChild:thumbNode];
    }
    return self;
}

+(id)joystickWithThumb:(SKSpriteNode *)aNode
{
    return [[self alloc] initWithThumb:aNode];
}

-(id) initWithThumb: (SKSpriteNode*) aNode andBackdrop: (SKSpriteNode*) bgNode
{
    if( self = [self initWithThumb: aNode])
    {
        [bgNode setPosition: self.anchorPointInPoints];
        [self addChild:bgNode];
    }
    return self;
}

+(id) joystickWithThumb:(SKSpriteNode *)thumbNode andBackdrop:(SKSpriteNode *)backgroundNode
{
    return [[self alloc] initWithThumb:thumbNode andBackdrop:backgroundNode];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isTracking == NO)
    {
        isTracking = YES;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (isTracking == YES)
    {
        for (UITouch *touch in touches)
        {
            CGPoint touchPoint = [touch locationInNode:self];
            if (sqrtf(powf((touchPoint.x - self.anchorPointInPoints.x), 2) + powf((touchPoint.y - self.anchorPointInPoints.y), 2)) <= thumbNode.size.width)
            {
                CGPoint moveDifference = CGPointMake(touchPoint.x - self.anchorPointInPoints.x, touchPoint.y - self.anchorPointInPoints.y);
                
                thumbNode.position = CGPointMake(self.anchorPointInPoints.x + moveDifference.x, self.anchorPointInPoints.y + moveDifference.y);
            }
            else
            {
                double vX = touchPoint.x - self.anchorPointInPoints.x;
                double vY = touchPoint.y - self.anchorPointInPoints.y;
                double magV = sqrt(vX*vX + vY*vY);
                double aX = self.anchorPointInPoints.x + vX / magV * thumbNode.size.width;
                double aY = self.anchorPointInPoints.y + vY / magV * thumbNode.size.width;
                
                thumbNode.position = CGPointMake(aX, aY);
            }
        }
        velocity = CGPointMake(((thumbNode.position.x - self.anchorPointInPoints.x)), ((thumbNode.position.y - self.anchorPointInPoints.y)));
        
        angularVelocity = -atan2(thumbNode.position.x - self.anchorPointInPoints.x, thumbNode.position.y - self.anchorPointInPoints.y);
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resetVelocity];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resetVelocity];
}

-(void) resetVelocity {
	isTracking = NO;
	velocity = CGPointZero;
    SKAction *easeOut = [SKAction moveTo:self.anchorPointInPoints duration:kThumbSpringBackDuration];
    easeOut.timingMode = SKActionTimingEaseOut;
    [thumbNode runAction:easeOut];
}

@end
