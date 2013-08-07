Joystick TheSneakyNarwhal
========

Joystick class for Sprite Kit

                        To make the joystick

1.Import the Joystick.h class to the header file of your scene.

2.Declare an instance of Joystick --> (Joystick *joystick).

3.Make the the sprites for the joystick image and backdrop.

4.Then initialize the joystick with the created SkSpriteNodes.

5.Position The sprite (preferably --> CGPointMake(joystick.size.width/2, joystick.size.height/2)).

6.Add the child to the scene

    SKSpriteNode *jsThumb = [SKSpriteNode spriteNodeWithImageNamed:@"joystick"];
    SKSpriteNode *jsBackdrop = [SKSpriteNode spriteNodeWithImageNamed:@"dpad"];
    joystick = [Joystick joystickWithThumb:jsThumb andBackdrop:jsBackdrop];
    joystick.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:joystick];

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

    TheSneakyNarwhal
