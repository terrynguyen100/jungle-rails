describe('Products Home Page', () => {
  
  
  it("register an account successfully", () => {
    cy.visit('/signup/');
    cy.get('#user_name').type('aaa');
    cy.get('#user_email').type('aaa@aaa.com');
    cy.get('#user_password').type('password123');
    cy.get('#user_password_confirmation').type('password123');

    cy.get('input[type="submit"]').click();

    // This test only works once every time we reset the cypress
    // Because once the user is registered, it can't register again
    cy.get('body').should('contain', 'Signed in as aaa')
  });

  it("add into cart when the Add button is clicked when logged in", () => {
    // log in before click on cart
    cy.visit('/login/');
    cy.get('#email').type('aaa@aaa.com');
    cy.get('#password').type('password123');
    cy.get('input[type="submit"]').click();
    cy.get('body').should('contain', 'Signed in as aaa')

    cy.visit('/');
    cy.get('button.btn').first().click({scrollBehavior:false, force: true});
    cy.get('.nav-link').should('contain', 'My Cart (1)');
  });

});
