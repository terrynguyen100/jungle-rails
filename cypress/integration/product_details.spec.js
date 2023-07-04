describe('Integration Test', () => {
  it("navigate from home page to product detail page by clicking on a product", () => {
    cy.visit('/');
    cy.get('.product').first().click();
    cy.url().should('contain', '/products/2');
  });
});

describe("Product Detail Page", () => {
  beforeEach(() => {
    cy.visit("/products/1/");
  });

  it("Displays the product name", () => {
    cy.get(".product-detail h1").should("contain", "Giant Tea");
  });

  it("Displays the product description", () => {
    cy.get(".product-detail p").should("contain", "The Giant Tea is an uncommon, medium-sized plant and can be found only in some tundras. It blooms twice a year, for 3 weeks.");
  });

  it("Displays the product image", () => {
    cy.get(".product-detail .main-img").should("be.visible");
  });

  it("Displays the 'Add to Cart' button", () => {
    cy.get(".product-detail .btn").should("contain", "Add");
  });

  it("Displays the stock quantity information", () => {
    cy.get(".product-detail .quantity").should("contain", 0);
  });
});
