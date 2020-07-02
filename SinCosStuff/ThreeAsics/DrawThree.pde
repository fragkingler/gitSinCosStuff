class Three {
  private float x, y, rgba, r, g, b, calc, red, blue, bg, baseHeight;

  Three( float x, float y, float rgba, float r, float g, float b, float bg, float baseHeight ) {
    this.x = x;
    this.y = y;
    this.rgba = rgba;
    this.r = r;
    this.g = g;
    this.b = b;
    this.bg = bg;
    this.baseHeight = baseHeight;
  }

  void drawThree() {

    noStroke();

    if ( this.rgba > ( this.bg / 1.3 ) )  // limiting the transparency for the people inside the room
      this.rgba = ( this.bg / 1.3 );

    this.calc = this.rgba / this.bg;  // calc offset between opacity and background

    this.red = this.bg - this.r;
    this.r = this.r + ( this.red * this.calc );

    this.g = this.rgba;

    this.blue = this.bg - this.b;
    this.b = this.b + ( this.blue * this.calc );

    fill( this.r, this.g, this.b ); // the three that is visible and changes colors depending on the temperature
    rect( this.x - ( this.baseHeight / 2 ), this.y - ( this.baseHeight / 2 ), this.baseHeight / 2, this.baseHeight, this.baseHeight / 6 );
    rect( this.x - ( this.baseHeight / 2.5 ), this.y - ( this.baseHeight / 2 ), this.baseHeight / 6, this.baseHeight / 10 );
    rect( this.x - ( this.baseHeight / 2.5 ), this.y + ( this.baseHeight / 2 - (this.baseHeight / 10 ) ), this.baseHeight / 6, this.baseHeight / 10 );

    fill( this.bg ); // covers parts of the three to make it the actual logo
    rect( this.x - ( this.baseHeight / 2 ), this.y - ( this.baseHeight / 2 - ( this.baseHeight / 10 ) ), this.baseHeight / 2.5, this.baseHeight / 3 + ( this.baseHeight / 75 ), this.baseHeight / 10 );
    rect( this.x - ( this.baseHeight / 2 ), this.y + ( this.baseHeight / 6.5 - ( this.baseHeight / 10 ) ), this.baseHeight / 2.5, this.baseHeight / 3 + (this.baseHeight / 75), this.baseHeight / 10 );
    rect( this.x - ( this.baseHeight / 2) + ( this.baseHeight / 10 ), this.y - ( this.baseHeight / 2 ) + ( this.baseHeight / 10 ), this.baseHeight / 10, this.baseHeight - ( this.baseHeight / 5 ) );

    fill( this.r, this. g, this.b );  // the adjustable line for the amount of people inside the room
    rect( this.x - ( this.baseHeight / 2 ) - 1, this.y - ( this.baseHeight / 2 ), this.baseHeight / 10 + 2, this.baseHeight );
  }
}
