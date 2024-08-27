SELECT * FROM bank_loan_data bld;

SELECT COUNT(id) AS Total_Loan_Applications 
FROM bank_loan_data bld;

-- P/MTD TOTAL LOAN APPLICATIONS
SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 12 
AND YEAR(issue_date) = 2021;

SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 11 
AND YEAR(issue_date) = 2021;

-- P/MTD TOTAL FUNDED AMOUNT
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount 
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- P/MTD TOTAL AMOUNT RECEIVED
SELECT SUM(total_payment) AS MTD_Total_Amount_received 
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(total_payment) AS PMTD_Total_Amount_received 
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- P/MTD AVERAGE INTEREST RATE
SELECT ROUND(AVG(int_rate), 4) * 100 AS MTD_Avg_Interest_Rate 
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(int_rate), 4) * 100 AS PMTD_Avg_Interest_Rate 
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- P/MTD AVERAGE DTI (Debt-To-Income Ratio)

SELECT ROUND(AVG(dti), 4) * 100 AS MTD_Avg_DTI
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(dti), 4) * 100 AS PMTD_Avg_DTI
FROM bank_loan_data bld
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- Percentage of good loans
SELECT
	(COUNT(CASE WHEN loan_status = 'Fully Paid' 
	OR loan_status = 'Current' THEN id END) * 100)
	/
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data bld;

-- Amount of good loan applications/etc.
SELECT COUNT(id) AS Good_Loan_Applications
FROM bank_loan_data bld
WHERE loan_status = "Fully Paid" OR loan_status = "Current";

SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan_data bld
WHERE loan_status = "Fully Paid" OR loan_status = "Current";

SELECT SUM(total_payment) AS Good_Loan_Received_Amount
FROM bank_loan_data bld
WHERE loan_status = "Fully Paid" OR loan_status = "Current";

-- Percentage of bad loans
SELECT
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100)
	/
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data bld;

-- Amount of bad loan applications/etc.
SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank_loan_data bld
WHERE loan_status = "Charged Off";

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan_data bld
WHERE loan_status = "Charged Off";

SELECT SUM(total_payment) AS Bad_Loan_Received_Amount
FROM bank_loan_data bld
WHERE loan_status = "Charged Off";

-- Loan Status

SELECT 
	loan_status,
	COUNT(id) AS Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate * 100) AS Interest_Rate,
	AVG(dti * 100) AS DTI
FROM
	bank_loan_data bld
GROUP BY
	loan_status;

-- MTD Loan Status
SELECT 
	loan_status,
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM
	bank_loan_data bld
	WHERE MONTH(issue_date) = 12
GROUP BY
	loan_status;
	
-- MONTH
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATE_FORMAT(issue_date, '%M') AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATE_FORMAT(issue_date, '%M')
ORDER BY MONTH(issue_date);

-- STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

-- TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

-- PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

-- HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;

-- GRADE & PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;















-- ----------------------------------------------------
-- CREATE TABLE sqlproj.bank_data_loan (
-- 	id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
-- 	address_state VARCHAR(50) NOT NULL,
-- 	application_type VARCHAR(50) NOT NULL,
-- 	emp_length VARCHAR(50) NOT NULL,
-- 	emp_title VARCHAR(100) NULL,
-- 	grade VARCHAR(50) NOT NULL,
-- 	home_ownership VARCHAR(50) NOT NULL,
-- 	issue_date DATE NOT NULL,
-- 	last_credit_pull_date DATE NOT NULL,
-- 	last_payment_date DATE NOT NULL,
-- 	loan_status VARCHAR(50) NOT NULL,
-- 	next_payment_date DATE NOT NULL,
-- 	member_id INTEGER NOT NULL,
-- 	purpose VARCHAR(50) NOT NULL,
-- 	sub_grade VARCHAR(50) NOT NULL,
-- 	term VARCHAR(50) NOT NULL,
-- 	verification_status VARCHAR(50) NOT NULL,
-- 	annual_income FLOAT NOT NULL,
-- 	dti FLOAT NOT NULL,
-- 	installment FLOAT NOT NULL,
-- 	int_rate FLOAT NOT NULL,
-- 	loan_amount INTEGER NOT NULL,
-- 	total_acc TINYINT NOT NULL,
-- 	total_payment INTEGER NOT NULL
-- )
-- ENGINE=InnoDB
-- DEFAULT CHARSET=utf8mb4
-- COLLATE=utf8mb4_0900_ai_ci;
