CREATE DATABASE Project;
USE Project;

CREATE TABLE Loan_Data (
    Customer_ID VARCHAR(20),
    Age INT,
    Gender VARCHAR(10),
    Marital_Status VARCHAR(20),
    Education VARCHAR(20),
    Employment_Type VARCHAR(30),
    Annual_Income INT,
    Loan_Amount INT,
    Loan_Term INT,
    Credit_Score INT,
    Existing_Loan VARCHAR(10),
    Property_Area VARCHAR(20),
    State VARCHAR(50),
    Loan_Purpose VARCHAR(50),
    Loan_Status VARCHAR(20),
    Default_Status VARCHAR(10),
    Interest_Rate DECIMAL(5,2),
    EMI DECIMAL(10,2)
);

# 1.Total Loan Applications 

SELECT COUNT(*) AS Total_Applications
FROM Loan_Data;

# 2.Total Approved Loans

SELECT COUNT(*) AS Total_Approved_loans
FROM Loan_data
WHERE Loan_Status = "Approved";

# 3.Total Rejected Loans

SELECT COUNT(*) AS Total_Rejected_loans
FROM Loan_data
WHERE Loan_Status = "Rejected";

# 4.Loan Approval Rate

SELECT
ROUND(
COUNT(CASE WHEN Loan_Status='Approved' THEN 1 END)
*100.0/COUNT(*),2
) AS Approval_Rate
FROM Loan_Data;

# 5.Default Rate

SELECT
ROUND(
COUNT(CASE WHEN Default_Status='Yes' THEN 1 END)
*100.0/COUNT(*),2
) AS Default_Rate
FROM Loan_Data;

# 6. Average Loan Amount

SELECT
ROUND(AVG(Loan_Amount),2) AS Avg_Loan_Amount
FROM Loan_Data;

# 7.Total Loan Amount Approved

SELECT
SUM(Loan_Amount) AS Total_Approved_Amount
FROM Loan_Data
WHERE Loan_Status='Approved';

# 8. State-wise Loan Applications

SELECT
State,
COUNT(*) AS Applications
FROM Loan_Data
GROUP BY State
ORDER BY Applications DESC;

# 9. State-wise Default Count

SELECT
State,
COUNT(*) AS Defaults
FROM Loan_Data
WHERE Default_Status='Yes'
GROUP BY State
ORDER BY Defaults DESC;

# 10. Top 5 States with Highest Loan Amount

SELECT
State,
SUM(Loan_Amount) AS Total_Loan
FROM Loan_Data
GROUP BY State
ORDER BY Total_Loan DESC
LIMIT 5;

# 11. Loan Purpose Analysis

SELECT
Loan_Purpose,
COUNT(*) AS Total_Loans
FROM Loan_Data
GROUP BY Loan_Purpose
ORDER BY Total_Loans DESC;

# 12. Loan Purpose with Highest Defaults

SELECT
Loan_Purpose,
COUNT(*) AS Defaults
FROM Loan_Data
WHERE Default_Status='Yes'
GROUP BY Loan_Purpose
ORDER BY Defaults DESC;

# 13. Average Credit Score by Loan Status

SELECT
Loan_Status,
ROUND(AVG(Credit_Score),2) AS Avg_Credit_Score
FROM Loan_Data
GROUP BY Loan_Status;

# 14. Employment Type Risk Analysis

SELECT
Employment_Type,
COUNT(*) AS Defaults
FROM Loan_Data
WHERE Default_Status='Yes'
GROUP BY Employment_Type;

# 15. Income Group Analysis

SELECT
CASE
WHEN Annual_Income < 500000 THEN 'Low Income'
WHEN Annual_Income BETWEEN 500000 AND 1000000 THEN 'Middle Income'
ELSE 'High Income'
END AS Income_Group,
COUNT(*) AS Customers
FROM Loan_Data
GROUP BY Income_Group;

# 16. Highest Loan Amount Customers

SELECT
Customer_ID,
Loan_Amount
FROM Loan_Data
ORDER BY Loan_Amount DESC
LIMIT 10;

# 17. Average EMI by Loan Purpose

SELECT
Loan_Purpose,
ROUND(AVG(EMI),2) AS Avg_EMI
FROM Loan_Data
GROUP BY Loan_Purpose;

# 18. Credit Score Category Analysis

SELECT
CASE
WHEN Credit_Score < 600 THEN 'Poor'
WHEN Credit_Score BETWEEN 600 AND 749 THEN 'Good'
ELSE 'Excellent'
END AS Credit_Category,
COUNT(*) AS Customers
FROM Loan_Data
GROUP BY Credit_Category;

# 19. High Risk Customers

SELECT
Customer_ID,
Credit_Score,
Annual_Income,
Loan_Amount
FROM Loan_Data
WHERE Credit_Score < 600
AND Loan_Amount > 1000000;

# 20. Top 10 Customers Paying Highest EMI

SELECT
Customer_ID,
EMI
FROM Loan_Data
ORDER BY EMI DESC
LIMIT 10;