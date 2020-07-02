int x, y, bg, counter = 0;
float baseheight, baseheightcsv, rgbl, r, g, b, w, wcalc, hcalc, h, y2, anwcalc;
PFont font;
Three three;
boolean blink, blink1, hasbg = false;
ArrayList <Three> logos;
Table data;


void setup() { 
  logos = new ArrayList <Three> ();
  baseheight = 700; // setting size of the logo
  size( 1500, 1000 ); // length has to be at least 1.5 times height
  x=width / 2;
  y=height / 2;

  if ( baseheight > y )  // limiting size of logo
    baseheight = y;

  font = createFont( "Play Bold", baseheight );  // implementing the font as vectors for best quality
  textFont( font, baseheight );
  textAlign( CENTER, CENTER );

  bg = 200;  // setting background colour
  background( bg );
  r = 0;
  g = 0;
  b = 0;
  rgbl = 0;
  
  //blink = true;
  //blink1 = true;
  //if ( blink == true )
  //  r = 255;
}

void draw() {


  background( bg );  // background to not have unlimited layers visible


  // Task Part 1 **

  if ( counter == 0 ) {

    fill( 0 ); // fill for text
    textFont( font, baseheight );
    text( "asics", x + ( baseheight / 3 ), y + ( baseheight / 50 ) );  //text&placement

    if ( r >= 0 && b <= 255 && blink == true ) {
      r = r - 1;
      b = b + 1;
      if ( r == 0 && b == 255 )
        blink = false;
    } else if ( r <= 255 && b >= 0 && blink == false )
    {
      r = r + 1;
      b = b - 1;
      if ( r == 255 && b == 0 )
        blink = true;
    }
    if ( rgbl <= bg && blink1 == true )
    {
      rgbl = rgbl + 1;
      if ( rgbl == bg )
        blink1 = false;
    } else if ( rgbl >= 0 && blink1 == false ) {
      rgbl = rgbl - 1;
      if ( rgbl == 0 )
        blink1 = true;
    }
  }

  // ** 

  // Task Part 2 ** 

  else if ( counter == 1 ) {

    fill( 0 ); // fill for text
    textFont( font, baseheight );
    text( "asics", x + ( baseheight / 3 ), y + ( baseheight / 50 ) );  //text&placement

    w = width;
    wcalc = 255 / w;
    r = wcalc * mouseX;
    b = 255 - r;
    h = height;
    hcalc = ( bg / h );
    rgbl = hcalc * mouseY;
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

      if ( baseheight > height / 5 && hasbg == false ) {
        background( bg );
        hasbg = true;
      } 
      if ( baseheight > height / 5 ) {
        baseheightcsv = height / 5;
        textFont( font, baseheightcsv );
      } else {
        baseheightcsv = baseheight;
        textFont( font, baseheight );
      }

      if ( i == 0 ) {
        y2 = y / 2 - (baseheightcsv/2);
      } else if ( i == 1 ) {
        y2 = y;
      } else if ( i == 2 ) { 
        y2 = y * 1.5 + (baseheightcsv/2);
      } else {
        background( bg );
        y2 = y;
      }

      r = temperatur;
      b = 255 - temperatur; 
      anwcalc = bg / 36;
      rgbl = bg - (anwesende * anwcalc);

      fill( 0 ); // fill for text
      if ( i <= 2 )
        text( "asics", x + ( baseheightcsv / 3 ), y2 + ( baseheightcsv / 50 ) );  //text&placement

      three = new Three ( x - ( baseheightcsv / 1.05 ), y2, rgbl, r, g, b, bg, baseheightcsv ); //x, y, rgbl, r, g, b, t, bg, baseheight
      logos.add( three );
      three.drawthree();    //drawing logo 3/b
    }
  }

  // ** 

  if (counter != 2) {

    three = new Three( x - ( baseheight / 1.05 ), y, rgbl, r, g, b, bg, baseheight ); // x, y, rgbl, r, g, b, t, bg, baseheight
    three.drawthree();    // drawing logo 3 / B
  }
}

void keyPressed() {
  if ( key == ' ' ) {
    if ( counter > 1 ) {
      counter = 0;
    } else if ( counter < 2 && hasbg == true ) {
      counter++; 
      hasbg = false;
    } else {
      counter++;
    }
  }
}