class Three {

  private int bg;
  private float x, y, gh, rgbl, r, g, b;

  Three( float x, float y, float rgbl, float r, float g, float b, int bg, float gh ) {
    this.x = x;
    this.y = y;
    this.rgbl = rgbl;
    this.r = r;
    this.g = g;
    this.b = b;
    this.bg = bg;
    this.gh = gh;
  }

  void drawthree() {

    noStroke();
    if ( this.rgbl > this.bg )  // limiting the transparency for the people inside the room
      this.rgbl = this.bg;

    //fill( 0 );
    //rect( 0, y + ( baseheight / 2 ), width, 1 );

    fill( this.r, this.g, this.b ); // the three that is visible and changes colors on remand of the temperature
    rect( this.x - ( this.gh / 2 ), this.y - ( this.gh / 2 ), this.gh / 2, this.gh, this.gh / 6 );
    rect( this.x - ( this.gh / 2.5 ), this.y - ( this.gh / 2 ), this.gh / 6, this.gh / 10 );
    rect( this.x - ( this.gh / 2.5 ), this.y + ( this.gh / 2 - (this.gh / 10 ) ), this.gh / 6, this.gh / 10 );

    fill( this.bg ); // covers parts of the three to make it the actual logo
    rect( this.x - ( this.gh / 2 ), this.y - ( this.gh / 2 - ( this.gh / 10 ) ), this.gh / 2.5, this.gh / 3 + ( this.gh / 75 ), this.gh / 10 );
    rect( this.x - ( this.gh / 2 ), this.y + ( this.gh / 6.5 - ( this.gh / 10 ) ), this.gh / 2.5, this.gh / 3 + (this.gh / 75), this.gh / 10 );
    rect( this.x - ( this.gh / 2) + ( this.gh / 10 ), this.y - ( this.gh / 2 ) + ( this.gh / 10 ), this.gh / 10, this.gh - ( this.gh / 5 ) );

    fill( this.rgbl );  // the adjustable line for the amount of people inside the room
    rect( this.x - ( this.gh / 2 ) - 1, this.y - ( this.gh / 2 ), this.gh / 10 + 2, this.gh );
  }
}