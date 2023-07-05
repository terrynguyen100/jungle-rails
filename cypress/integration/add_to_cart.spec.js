describe('Products Home Page', () => {
  it("add into cart when the Add button is clicked when logged in", () => {
    cy.visit('/');
    cy.get('button.btn').first().click({scrollBehavior:false, force: true});
    cy.get('.nav-link').should('contain', 'My Cart (1)');
  });

});
