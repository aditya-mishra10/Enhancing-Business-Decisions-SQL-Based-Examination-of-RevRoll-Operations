# Enhancing-Business-Decisions-SQL-Based-Examination-of-RevRoll-s-Operations
### Project Description: SQL Analysis for Optimizing RevRoll’s Business Operations

This project aims to enhance the business operations of RevRoll, an automotive parts dealer and installer, through detailed SQL analysis. The project will address four key business questions to provide actionable insights and support strategic decision-making.

**1. Identifying Top Customers by Order Volume**
To understand which customers are most engaged with RevRoll’s services, we will write a query to identify the customer(s) with the most orders. This query will return the preferred names of these customers, enabling RevRoll to recognize and potentially reward their most loyal customers.

**2. Targeting Valuable Self-Install Customers**
RevRoll wants to encourage customers who prefer to install parts themselves, as this is a valuable segment of their business. We will identify customers who have made at least $2000 in purchases of parts that were not installed by RevRoll. The query will return the customer ID and preferred name, allowing RevRoll to target these customers with special offers and promotions to drive further sales.

**3. Recommending Additional Products to Customers**
To boost sales through personalized recommendations, we will report the IDs and preferred names of customers who have purchased both an Oil Filter and Engine Oil but have not bought an Air Filter. By identifying these customers, RevRoll can recommend the purchase of an Air Filter, potentially increasing sales and improving customer satisfaction with tailored suggestions.

**4. Calculating the Cumulative Part Summary for Installed Parts**
We will develop a solution to calculate the cumulative part summary for every part installed by RevRoll. This summary will be a 3-month rolling sum of the price times the quantity for each month a part was installed, excluding the most recent month and any months where the part was not installed. This analysis will provide insights into the demand and financial performance of specific parts over time, helping RevRoll optimize inventory and installation services.

By addressing these four questions, the project will deliver a comprehensive SQL analysis that enhances RevRoll’s understanding of customer behavior, improves targeted marketing efforts, and optimizes inventory management. This data-driven approach will support RevRoll’s goal of increasing sales, improving customer satisfaction, and streamlining operations.

**Data Dictionary**

**Table 1-- customers: customer details**

customer_id: unique customer ID (key, integer)

preferred_name: name preferred by the customer (varchar(50))

**Table 2-- installers: information about installers**

installer_id: unique installer ID (key, integer)

name: name of the installer (varchar(50))

**Table 3-- installs: records of installations**

install_id: unique install ID (key, integer)

order_id: ID of the order (integer)

installer_id: ID of the installer (integer)

install_date: date of installation (date)

**Table 4-- orders: details of customer orders**

order_id: unique order ID (key, integer)

customer_id: ID of the customer (integer)

part_id: ID of the part ordered (integer)

quantity: number of parts ordered (integer)

**Table 5-- parts: information about parts**

part_id: unique part ID (key, integer)

name: name of the part (varchar(50))

price: price of the part (numeric)

**Table 6-- install_derby: records of installer competitions**

derby_id: unique derby ID (key, integer)

installer_one_id: ID of the first installer (integer)

installer_two_id: ID of the second installer (integer)

installer_one_time: time taken by the first installer (integer)

installer_two_time: time taken by the second installer (integer)
