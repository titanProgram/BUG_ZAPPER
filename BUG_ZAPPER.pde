/*
  Developer: Byron Farrell
  Date created: 19/09/2017
  Last update: 19/09/2017
  
  Descripstion:
  The user will be able to control a 2d spaceship that can site a laser. A bug 
  will slowly move down the screen moving in random directions. If the player 
  hits the bug they get +1 add onto their score. The longer the player survives 
  the fast the bug will move. If the bug gets to the bottom of the screen the 
  game will end.
  
  TO DO:
  1. create cool background, stary sky?
    - when the game start create a stary sky background that randomly generates
    stars x and y posistion. the stars should have a distance between each other
    that can not be less than the pre-definded distance i.e. 20px
  2. create inbound function ( boolean? )
  3. create game start mode
    - when the player loses end game
  4. create bug reset function, when the player kills a bug the bug should be reset
  and the players score should get +1
  
  FIXME:
  1. I can't use a while loop within the draw function! This means I will have to restructer
  my code. Try putting the main gameState in a function and calling that function in the
  pre-defined draw() function.
*/

// GLOBAL VARIABLES
boolean gameState = true;

float randomX = 50;
float randomY = 50;


// bug object variables
float bugX = width/2;
float bugY = 0;

// DECLARING OBJECTS
bug bugObject;
player playerObject;

void setup() 
{
  size( 500, 500 );
  frameRate( 60 );
  // CREATING OBJECTS
  bugObject = new bug( 25, 1, color( 0, 100, 0 ), color( 0, 255, 0 ), color( 255, 255, 0 ) );
  playerObject = new player( 100, 1 );
}// END setup()

void draw() 
{
      
  if ( frameCount % 60 == 0 )
  {
    bugX += random( 50, 50 );
    bugY += random( 10, 25 );// random( bugSpeed, bugSpeed * 2 )?
    if ( !inBoundsX( bugX ) )
    {
      if ( bugX - bugObject.bugsize > width )
      {
      bugX += random( -100, -50 );
      }// END if()
      else if ( bugX < 0 )
      {
        bugX += random( 50, 100 );
      }// END else if()
    }// END if()
    bugObject.display( bugX, bugY );
  }// END if()
  //playerObject.display( 0, 0 );
  //if key 'w' == true player.shoot
  //if key 'a' or 'd' player.moveLeft or player.moveRight
}// END draw()

// FUNCTIONS

/*
  function game
  
  The function game will where all the main game controls and interactions are changed.
  all error checking and updating etc will be done in the game function
*/
void game()
{
  while ( gameState )
  {
    if ( frameCount % 60 == 0 )
    {
      
    }// END if()
  }// END while()
}// END game()
/*
  functon inBounds
  
  this function will return true if the x co-ordinates are within the bounds of the screen
  if the x co-ordinate is out of the bounds of the screen it will return falsedsw
*/
boolean inBoundsX( float x )
{
  if ( x >= 0 && x <= width )
  {
    return true;
  }// END if()
  else 
  {
    return false;
  }// END else
}// END inBounds()

// CLASSES

/* 
  class bug
  The clas bug will create an object of type bug. 
  
  TO DO:
  1. the object will gets it x and y co-ordinates from a global variable
  2. the object will have a global variable that will determine its size
  3. the object will have a global variable that determines its speed
  4. the object will have a function that moves it down the screen in random 
  directions on the x and y axis
    - use the dislay function to move the bug?
  5. the object will have a reset function that will reset the bug to a random 
  position at the top of the screen, when the player kill it
  6. adjust stroke weight depending on size: size 20 strokeWeight 0.2?
  ( divide size by 100 to get strokeWeight value )
  7. add color argument to constructor
  
  NOTE:
  1. can global variables be put inside the class if it  is public?
*/

class bug
{
  // DATA
  
  // PShape is a data type that stores shapes
  // A variety of shapes will be combined and stored in the bugShape variable
  PShape bugShape = createShape( GROUP );
  float bugsize;
  // CONTRUCTOR
  bug( float bugSize, float bugSpeed, color color1, color color2, color antennaColor )
  {
    bugsize = bugSize;
    // Creating shapes to be added to the bugShape variable
    // main body of the bug
    stroke( color1 );
    fill( color2 );
    PShape body = createShape( TRIANGLE, bugSize, 0, bugSize / 2, bugSize, bugSize * 1.5, bugSize );
    // bug legs
    PShape topLeftLeg = createShape( LINE, bugSize * 0.90, bugSize / 5, bugSize * 0.75, bugSize * -0.25 );
    PShape topRightLeg = createShape( LINE, bugSize * 1.1, bugSize / 5, bugSize * 1.25, bugSize  * -0.25 );
    PShape middleLeftLeg = createShape( LINE, bugSize * 0.75, bugSize / 2, bugSize * 0.6, bugSize / 8 );
    PShape middleRightLeg = createShape( LINE, bugSize * 1.25, bugSize / 2, bugSize * 1.4, bugSize / 8 );
    PShape bottomLeftLeg = createShape( LINE, bugSize * 0.60, bugSize * 0.8 , bugSize * 0.45, bugSize * 0.375 );
    PShape bottomRightLeg = createShape( LINE, bugSize * 1.40, bugSize * 0.8, bugSize * 1.55, bugSize * 0.375 );
    // spots on the bugs body
    fill( color1 );
    PShape bugSpot1 = createShape( ELLIPSE, bugSize * 1.25, bugSize * 0.85, bugSize / 10, bugSize / 8 );
    PShape bugSpot2 = createShape( ELLIPSE, bugSize * 1.1, bugSize * 0.70, bugSize / 11, bugSize / 12 );
    PShape bugSpot3 = createShape( ELLIPSE, bugSize * 0.75, bugSize * 0.80, bugSize / 10, bugSize / 8 );
    PShape bugSpot4 = createShape( ELLIPSE, bugSize * 0.90, bugSize * 0.45, bugSize / 10, bugSize / 12 );
    PShape bugSpot5 = createShape( ELLIPSE, bugSize * 1.03, bugSize * 0.25, bugSize / 12, bugSize / 11 );
    // bug head
    PShape head = createShape( TRIANGLE, bugSize, bugSize * 1.5, bugSize * 0.60, bugSize, bugSize * 1.4, bugSize );
    // bug antenna
    fill( antennaColor );
    PShape leftAntenna = createShape( LINE, bugSize * 0.80, bugSize * 1.25, bugSize * 0.6, bugSize * 1.6 );
    PShape leftAntennaBall = createShape( ELLIPSE, bugSize * 0.6, bugSize * 1.6, bugSize / 12, bugSize / 12 );
    PShape rightAntenna = createShape( LINE, bugSize * 1.2, bugSize * 1.25, bugSize * 1.4, bugSize * 1.6 );
    PShape rightAntennaBall = createShape( ELLIPSE, bugSize * 1.4, bugSize * 1.6, bugSize / 12, bugSize / 12 );
    
    // adding shapes together
    bugShape.addChild( body );
    bugShape.addChild( topLeftLeg );
    bugShape.addChild( topRightLeg );
    bugShape.addChild( middleLeftLeg );
    bugShape.addChild( middleRightLeg );
    bugShape.addChild( bottomLeftLeg );
    bugShape.addChild( bottomRightLeg );
    bugShape.addChild( bugSpot1 );
    bugShape.addChild( bugSpot2 );
    bugShape.addChild( bugSpot3 );
    bugShape.addChild( bugSpot4 );
    bugShape.addChild( bugSpot5 );
    bugShape.addChild( head );
    bugShape.addChild( leftAntenna );
    bugShape.addChild( leftAntennaBall );
    bugShape.addChild( rightAntenna );
    bugShape.addChild( rightAntennaBall );
  }// END bug()
  
  // FUNCTIONS
  
  /*
    function display
    
    The display function will display the bugShape at a x and y co-ordinate
    specified in the arguments
  */
  void display( float x, float y )
  {
    strokeWeight( 2 );
    translate( x, y );
    shape( bugShape );
  }// END display()
}// END bug

/*
  class player
  
  TO DO:
  1. the player object will have a global variable that will control its speed
  2. the player object will have a global variable that will determine its size
  3. the player object will have a global variable that will control it x and y 
  co-ordinates
  4. the player object will be able to move left and right
  5. the player object will have a shoot function
*/
class player
{
  // DATA
  PShape playerShape = createShape( GROUP );
  
  // CONTRUCTOR
  player( float playerSize, float playerSpeed )
  {
    // the shapes below will be combined and stored in the playerShape variable
    PShape topLine = createShape( LINE, 0, 0, playerSize, 0 );
    PShape topRightCorner = createShape( LINE, 0, 0, playerSize * -0.2, playerSize * 0.05 );
    PShape topLeftCorner = createShape( LINE, playerSize, 0, playerSize * 1.2, playerSize * 1.2 );
    PShape bottomLine = createShape( LINE, 0, playerSize / 2, playerSize, playerSize / 2 );
    strokeWeight( 2 );
    playerShape.addChild( topLine );
    playerShape.addChild( topRightCorner );
    playerShape.addChild( topLeftCorner );
    
    
  }// END player()
  
  // FUNCTIONS
  
  /*
    display function
    
    the display function will display the shape playerShape at the specified
    x and y co-ordinates
  */
  void display( float x, float y )
  {
    translate( x, y );
    shape( playerShape );
  }// END display()
}// END player