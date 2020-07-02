int x, y, counter = 0;
float baseHeight, baseHeightCSV, bg, rgba, r, g, b, w, wCalc, h, hCalc, y2, anwCalc, imgCalc; // rgba = Opacity variable also used as green fill value; wCalc = calculating width temp's (same for hCalc); anwCalc = calculating anwesende from table; y2 = new y for multiple logos to be drawn
PImage img;
Three three;
boolean cFade = true, anwCalcAnim, stopAnwCalcAnim, hasRun = false;
ArrayList <Three> logos;
Table data;


void setup() { 
  logos = new ArrayList <Three> ();

  r = 0;
  g = 0;
  b = 0;
  rgba = 0;

  // ** ADJUSTABLE AREA ** //

  bg = 255;  // setting background colour
  baseHeight = 300; // setting size of the logo; proceed with cauction
  if ( cFade == true ) { // setting start color for anim-Modus
    r = 255;
    b = 0;
    rgba = 0;
  }

  //fullScreen();

  background( bg );

  size( 1200, 700 ); // width has to be at least 1.5 times height; proceed with cauction
  frameRate(60);

  // ** END OF ADJUSTABLE AREA ** //

  x=width / 2;
  y=height / 2;

  if ( baseHeight > y )  // limiting size of logo
    baseHeight = y;

  img = loadImage("asics.png");
  imageMode(CENTER);
  imgCalc = 255 / bg;
}

void draw() {

  background( bg );  // background to not have unlimited layers visible

  // Task Part 1 **

  if ( counter == 0 ) {
    if ( hasRun == true) {
      r = 255;
      b = 0;
      rgba = 0;
      hasRun = false;
      cFade = true;
      anwCalcAnim = true;
      stopAnwCalcAnim = false;
    }

    if ( r >= 0 && b <= 255 && cFade == true ) {
      r = r - 1;
      b = b + 1;
      if ( r == 0 && b == 255 )
        cFade = false;
    } else if ( r <= 255 && b >= 0 && cFade == false ) {
      r = r + 1;
      b = b - 1;
      if ( r == 255 && b == 0 )
        cFade = true;
    }
    if ( anwCalcAnim == true  && stopAnwCalcAnim == false) {
      rgba = (int)rgba - 1;
      if ( (int)rgba <= 0 ) 
      {
        rgba = (int)rgba + 1;
        anwCalcAnim = false;
      }
    } else if ( anwCalcAnim == false && stopAnwCalcAnim == false ) {
      rgba = (int)rgba + 1;
      if ( (int)rgba >= (int)( bg / 1.3 ) )
      { 
        rgba = (int)( bg / 1.3 ) - 1;
        anwCalcAnim = true;
      }
    }
    tint( 0, 255 - rgba * imgCalc );
    image( img, x + ( baseHeight / 3 ), y + baseHeight / 6.4, baseHeight * 2.3, baseHeight / 1.45 );
  }

  // ** 

  // Task Part 2 ** 

  else if ( counter == 1 ) {

    w = width;
    wCalc = 255 / w;
    r = wCalc * mouseX;
    b = 255 - r;
    h = height;
    hCalc = ( ( bg / 1.3 ) / h );
    rgba = hCalc * mouseY;

    tint( 0, 255 - rgba * imgCalc );
    image( img, x + ( baseHeight / 3 ), y + baseHeight / 6.4, baseHeight * 2.3, baseHeight / 1.45  );
  }

  // **

  // Task Part 3 ** 

  else if ( counter == 2 ) {

    data = loadTable( "werte.csv", "header" );

    for ( int i = 0; i < data.getRowCount(); i++ ) {

      TableRow row = data.getRow( i );
      float temperatur = row.getFloat( "temperatur" );
      temperatur = temperatur % 15;
      temperatur = temperatur * 17;
      float anwesende = row.getFloat( "anwesende" );

      if ( baseHeight > height / 5 && hasRun == false ) {
        background( bg );
        hasRun = true;
      } 
      if ( baseHeight > height / 5 ) {
        baseHeightCSV = height / 5;
      } else {
        baseHeightCSV = baseHeight;
      }

      if ( i == 0 ) {
        y2 = y / 2 - (baseHeightCSV/2);
      } else if ( i == 1 ) {
        y2 = y;
      } else if ( i == 2 ) { 
        y2 = y * 1.5 + (baseHeightCSV/2);
      } else {
        background( bg );
        y2 = y;
      }

      r = temperatur;
      b = 255 - temperatur; 
      anwCalc = bg / 36;
      rgba = ( bg / 1.3 ) - ( anwesende * anwCalc );

      if ( i <= 2 ) {
        tint( 0, 255 - rgba * imgCalc );
        image( img, x + ( baseHeightCSV / 3 ), y2 + baseHeightCSV / 6.4, baseHeightCSV * 2.3, baseHeightCSV / 1.45  );
      }

      three = new Three ( x - ( baseHeightCSV / 1.05 ), y2, rgba, r, g, b, bg, baseHeightCSV ); //x, y, rgbl, r, g, b, t, bg, baseheight
      logos.add( three );
      three.drawThree();    //drawing logo 3/b
    }
  }

  // ** 

  if (counter != 2) {

    three = new Three( x - ( baseHeight / 1.05 ), y, rgba, r, g, b, bg, baseHeight ); // x, y, rgbl, r, g, b, t, bg, baseheight
    three.drawThree();    // drawing logo 3 / B
  }
}

void keyPressed() {
  if ( key == ' ' ) {
    if ( counter > 1 ) {
      counter = 0;
    } else {
      counter++;
    }
  }
  if ( keyCode == ENTER && counter == 0) {
    r = 0;
    b = 0;
    rgba = 0;
    stopAnwCalcAnim = true;
  }
}
