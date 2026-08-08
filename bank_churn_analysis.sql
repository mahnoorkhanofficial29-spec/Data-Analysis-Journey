/*
===========================================================
                 BANK CUSTOMER CHURN ANALYSIS
===========================================================

Objective:
Analyze customer churn patterns using SQL to identify the
key factors associated with customer attrition and provide
data-driven business recommendations.

Dataset:
Bank Customer Churn Dataset

Skills Demonstrated:
• Aggregate Functions
• CASE Statements
• GROUP BY
• ORDER BY
• Conditional Aggregation
• Business Insight Generation
===========================================================
*/

-- QUERY: TOTAL NUMBER OF CUSTOMERS IN BANK
SELECT COUNT(*) AS Total_Customers
FROM customer;

-- QUERY: NUMBER OF CUSTOMERS WHO LEFT(EXITED=1) AND NUMBER OF CUSTOMERS THAT STAYED(EXITED=0)
SELECT
    Exited,
    COUNT(*) AS Customers
FROM customer
GROUP BY Exited;

-- QUERY: Overall Bank Churn Rate
SELECT
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS Churn_Rate
FROM customer;

-- QUERY:  Which country has the highest customer churn rate?
SELECT
    Geography,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
      ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS Churn_Rate
FROM customer
GROUP BY Geography
ORDER BY Churn_Rate DESC;
-- INSIGHT:
/*Germany has the highest churn rate (32.44%), almost twice that of France and Spain.
The bank should investigate customer satisfaction and retention strategies in Germany.
*/

-- QUERY: Which gender is more likely to leave the bank?
SELECT
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS Churn_Rate
FROM customer
GROUP BY Gender;
-- INSIGHT:Gender Analysis
/*
 Female customers have a higher churn rate than male customers. 
 This suggests the bank should investigate whether its products,
 services, or customer experience are meeting the needs of female customers.
 */


-- QUERY: Churn by age groups
SELECT
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS Churn_Rate
FROM customer
GROUP BY Age_Group
ORDER BY Churn_Rate DESC;
--  INSIGHT: AGE GROUP ANALYSIS
/*
Customers aged 50–59 have the highest churn rate.
 The bank should analyze why customers in this age group are leaving and consider targeted retention offers.
 */



-- QUERY: Churn by Active Membership
SELECT
    IsActiveMember,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS Churn_Rate
FROM customer
GROUP BY IsActiveMember
ORDER BY Churn_Rate DESC;
-- INSIGHT: Activity Analysis
/*
Inactive customers churn at a much higher rate than active customers. 
This indicates customer engagement is strongly related to retention, 
so the bank should focus on re-engaging inactive customers.
*/

-- QUERY: Churn by number of products
SELECT
    NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS Churn_Rate
FROM customer
GROUP BY NumOfProducts
ORDER BY NumOfProducts;
-- INSIGHT:
/*
Customer churn varies significantly based on the number of
banking products owned.

Customers with two products have the lowest churn rate
(7.58%), indicating that they are the most loyal customer
segment.

In contrast, customers with three products have a very high
churn rate (82.71%), while all customers with four products
in this dataset churned (100%). However, the four-product
group consists of only 60 customers, so this result should
be interpreted with caution due to the small sample size.

These findings suggest that customers with multiple products
may require closer monitoring to understand why they are
leaving. The bank should investigate whether product
complexity, pricing, or customer experience contributes to
the high churn among these customers.
 */

-- Query : Churn by Credit Card Ownership
SELECT
    HasCrCard,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS Churn_Rate
FROM customer
GROUP BY HasCrCard;
-- INSIGHT: 
/*
Customers with and without a credit card have very similar
churn rates (20.18% and 20.81%, respectively).

This suggests that credit card ownership alone has little
influence on customer churn. Other factors such as customer
activity, age, credit score, geography, and product usage
appear to have a much stronger impact on customer retention.

The bank should focus its retention strategies on these
higher-impact factors rather than relying on credit card
ownership as an indicator of churn risk.
*/


-- Query : Churn by Credit Score Category
SELECT
    CASE
        WHEN CreditScore < 500 THEN 'Poor'
        WHEN CreditScore BETWEEN 500 AND 699 THEN 'Average'
        ELSE 'Excellent'
    END AS Credit_Category,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) / COUNT(*)) * 100, 2) AS Churn_Rate
FROM customer
GROUP BY Credit_Category
ORDER BY Churn_Rate DESC;
 -- INSIGHT:
 /*
 
Customers with poor credit scores have the highest churn
rate (23.73%), followed by customers with average
(20.31%) and excellent (19.82%) credit scores.

This indicates that customers with lower credit scores are
slightly more likely to leave the bank. Although the
difference is not substantial, it suggests that financial
risk and customer creditworthiness may have some influence
on churn.

The bank should identify customers with poor credit scores
early and provide personalized financial products,
credit-improvement programs, and proactive customer support
to improve customer retention.
 */


-- QUERY: Churn by Balance Category

SELECT
    CASE
        WHEN Balance = 0 THEN 'Zero Balance'
        WHEN Balance < 50000 THEN 'Low Balance'
        WHEN Balance BETWEEN 50000 AND 100000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS Balance_Category,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited)/COUNT(*))*100,2) AS Churn_Rate
FROM customer
GROUP BY Balance_Category
ORDER BY Churn_Rate DESC;
-- INSIGHT
/*
Customers with low account balances have the highest churn
rate (34.67%), followed by customers with high balances
(25.23%).

Interestingly, customers with zero balances have the lowest
churn rate (13.82%).

This suggests that customers with some funds in their
accounts—especially those with low balances—may be more
sensitive to fees, service quality, or better offers from
competitors. The bank should investigate the reasons behind
their dissatisfaction and implement targeted retention
strategies.
*/

-- QUERY: Churn by Customer Tenure

SELECT
    CASE
        WHEN Tenure BETWEEN 0 AND 2 THEN '0-2 Years'
        WHEN Tenure BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN Tenure BETWEEN 6 AND 8 THEN '6-8 Years'
        ELSE '9-10 Years'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited)/COUNT(*))*100,2) AS Churn_Rate
FROM customer
GROUP BY Tenure_Group
ORDER BY Churn_Rate DESC;
 -- INSIGHT
 /*
Customers with 9–10 years of tenure have the highest churn
rate (21.30%), closely followed by customers with 0–2 years
(21.15%).

Customers with 6–8 years of tenure have the lowest churn
rate (18.87%).

The relatively small differences suggest that tenure alone
is not a strong predictor of churn. Other factors such as
customer activity, credit score, and product usage likely
have a greater influence on customer retention.
*/

-- QUERY: Churn by Estimated Salary

SELECT
    CASE
        WHEN EstimatedSalary < 50000 THEN 'Low Salary'
        WHEN EstimatedSalary BETWEEN 50000 AND 100000 THEN 'Medium Salary'
        ELSE 'High Salary'
    END AS Salary_Category,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited)/COUNT(*))*100,2) AS Churn_Rate
FROM customer
GROUP BY Salary_Category
ORDER BY Churn_Rate DESC;
-- INSIGHT:  
/*
Customers across all salary categories have very similar
churn rates, ranging from 19.87% to 20.84%.

This indicates that estimated salary has little influence
on customer churn. Other factors such as customer activity,
age, credit score, and geography appear to have a much
greater impact on whether a customer leaves the bank.

The bank should focus its retention efforts on behavioral
and demographic factors rather than customer salary.
*/

-- QUERY: Churn by Gender and Geography

SELECT
    Geography,
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited)/COUNT(*))*100,2) AS Churn_Rate
FROM customer
GROUP BY Geography, Gender
ORDER BY Churn_Rate DESC;
-- INSIGHT: 
/*
Female customers in Germany have the highest churn rate
(37.55%), making them the highest-risk customer segment.

Male customers in Germany also exhibit a high churn rate
(27.81%), while customers in France have the lowest churn
rates for both males (12.71%) and females (20.34%).

These results suggest that customer churn is influenced by
both geography and gender. The bank should prioritize
retention strategies for German customers, especially
female customers, through personalized products,
improved customer engagement, and targeted marketing
campaigns.
*/




/*
===========================================================
                KEY FINDINGS
===========================================================

1. Germany has the highest customer churn rate.

2. Female customers churn more frequently than male customers.

3. Customers aged 50–59 are the most likely to leave.

4. Inactive customers have a significantly higher churn rate.

5. Customers with poor credit scores are more likely to churn.

6. Churn varies across balance, tenure, and salary groups.

7. Customers with different numbers of products show different
   churn patterns, highlighting opportunities for cross-selling
   and retention.
*/

/*
===========================================================
            BUSINESS RECOMMENDATIONS
===========================================================

• Prioritize retention campaigns in Germany.

• Re-engage inactive customers through personalized offers
  and communication.

• Develop products and services targeted at customers aged
  50–59.

• Monitor customers with poor credit scores and provide
  suitable financial solutions.

• Focus on retaining high-value customers identified through
  balance and product analyses.

• Use churn insights to create targeted marketing campaigns
  for high-risk customer segments.
*/