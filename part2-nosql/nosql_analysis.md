# NoSQL Database Analysis for FlexiMart

## Section A: Limitations of Relational Databases (RDBMS)

Relational databases are well suited for structured and predictable data, but they become restrictive when handling highly diverse and evolving product catalogs. In an e-commerce context like FlexiMart, different product categories require different attributes. For example, electronics products include specifications such as RAM, processor, and battery capacity, while fashion products include size, color, material, and fit. Representing such variability in an RDBMS requires creating many nullable columns or multiple subtype tables, which increases schema complexity and maintenance effort.

Frequent schema changes are another limitation. Introducing a new product type often requires ALTER TABLE operations, which are expensive and risky on large datasets. Additionally, customer reviews are naturally hierarchical and nested in nature. In a relational model, reviews must be stored in separate tables and joined during queries, increasing query complexity and reducing performance for read-heavy workloads.

These limitations make relational databases less flexible and slower to adapt for rapidly changing product catalogs.

---

## Section B: Benefits of MongoDB for Product Catalog Management

MongoDB addresses these challenges through its flexible, document-based data model. Each product is stored as a JSON-like document, allowing different products to have different attributes without enforcing a rigid schema. This flexibility enables FlexiMart to store electronics specifications, fashion attributes, and future product types in a single collection without schema redesign.

MongoDB also supports embedded documents, which allows customer reviews to be stored directly inside product documents. This improves read performance by eliminating the need for joins and aligns naturally with how product data is consumed by applications. Horizontal scalability is another advantage, as MongoDB supports sharding, enabling the product catalog to scale efficiently as data volume and traffic increase.

Overall, MongoDB provides agility, scalability, and a data model that closely matches real-world product structures.

---

## Section C: Trade-offs of Using MongoDB

While MongoDB offers schema flexibility, it has trade-offs compared to MySQL. Complex multi-document transactions are harder to manage and less efficient, making financial consistency more challenging. Additionally, the absence of enforced foreign key constraints increases the risk of data inconsistency if application-level validation is weak.
