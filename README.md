Joystick -TheSneakyNarwhal
====================
![alt tag](https://raw.githubusercontent.com/TheSneakyNarwhal/SpriteKit-Joystick/master/pic.png)
====================
How to make the joystick
=====================

1.Import the Joystick.h class to the header file of your scene.

2.Declare an instance of Joystick --> (Joystick *joystick).

3.Make the the sprites for the joystick image and backdrop.

4.Then initialize the joystick with the created SkSpriteNodes.

5.Position The sprite (preferably --> CGPointMake(joystick.size.width/2, joystick.size.height/2)).

6.Add the child to the scene

    SKSpriteNode *jsThumb = [SKSpriteNode spriteNodeWithImageNamed:@"joystick"];
    SKSpriteNode *jsBackdrop = [SKSpriteNode spriteNodeWithImageNamed:@"dpad"];
    joystick = [Joystick joystickWithThumb:jsThumb andBackdrop:jsBackdrop];
    joystick.position = CGPointMake(jsBackdrop.size.width, jsBackdrop.size.height);
    [self addChild:joystick];
Movement
========

To use the joystick, use the velocity property --> (joystick.velocity.x/ joystick.velocity.y)
For movement, you can do something like,

    -(id)init
    {
         if (self = [super init]
          {
              velocityTick = [CADisplayLink displayLinkWithTarget:self selector:@selector(joystickMovement)];
              [velocityTick addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
          }
    }


    -(void)joystickMovement
    {
        if (joystick.velocity.x != 0 || joystick.velocity.y != 0)
        {
              player.position = CGPointMake(player.position.x + .1 *joystick.velocity.x, player.position.y + .1 * joystick.velocity.y);
        {
    }

Just make sure to import the QuartzCore framework and to declare the instances of the CADisplayLink
and the player in the header file

For animations you can do something like,

    if (joystick.velocity.x > 0)
    {
        [player walkRightAnim];
    }
    else if (joystick.velocity.x < 0)
    {
        [player walkLeftAnim];
    }
    if (joystick.velocity.y > 0)
    {
        [player walkUpAnim];
    }
    else if (joystick.velocity.y < 0)
    {
        [player walkDownAnim];
    }
    if (joystick.velocity.x == 0 && joystick.velocity.y == 0)
    {
        [player idleAnim];
    }

                                                        
Rotation
========

For rotation, use the joystick property angularVelocity (joystick.angularVelocity)

    if (joystick.velocity.x != 0 || joystick.velocity.y != 0)
    {
        player.zRotation = joystick.angularVelocity;
    }
    
PS: The formula for finding the radians of a point and the origin is -atan2(position.x - origin.x, position.y - origin.y)

If you want to find the angle in degrees, multiply the above formula by 180/M_PI

                                                        TheSneakyNarwhal
