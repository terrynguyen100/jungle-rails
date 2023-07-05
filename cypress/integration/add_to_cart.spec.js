describe('Products Home Page', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("add into cart when the Add button is clicked", () => {
    cy.get('button.btn').first().click({scrollBehavior:false, force: true});
    // this test only works if comment out "before_action :authorize" in CartsController
    cy.get('.nav-item .nav-link').should('contain', 'My Cart (1)');
  });

});
