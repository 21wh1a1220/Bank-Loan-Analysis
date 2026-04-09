select *from financial_loan;

select id,address_state,grade,issue_date,purpose,term,verification_status,total_payment FROM financial_loan;

select *from financial_loan
where annual_income>100000;

SELECT * FROM financial_loan
ORDER BY total_payment,loan_amount,dti,annual_income asc;

select id ,address_state,emp_title,last_payment_date,next_payment_date,installment from financial_loan
where address_state in ('CA','MI','MC','NY','NJ','NV','KY','PA','MD','MN','FL');

SELECT * FROM financial_loan
WHERE address_state LIKE 'A%';


SELECT * FROM financial_loan
WHERE address_state LIKE 'c%';

SELECT * FROM financial_loan
WHERE annual_income IS NOT NULL;

SELECT id, address_state, emp_length, next_payment_date, purpose,
       verification_status, int_rate, total_payment
FROM financial_loan
ORDER BY total_payment DESC;

SELECT TOP 20 * FROM financial_loan
ORDER BY total_payment, loan_amount ,int_rate DESC;

SELECT * FROM financial_loan
WHERE home_ownership = 'RENT';

SELECT 
    AVG(int_rate) as avg_int_rate,
    MAX(total_payment) as max_payment,
    MIN(total_payment) as min_payment,
    COUNT(*) as count_payment
FROM financial_loan;

SELECT id, total_payment,
CASE 
    WHEN total_payment > 10000 THEN 'High'
    WHEN total_payment > 5000 THEN 'Medium'
    ELSE 'Low'
END AS payment_category
FROM financial_loan;

# KPIs
1.total loan applications,MTD total loan applications,PMTD Loan Applications,
Total Funded Amount,MTD Total Funded Amount,PMTD Total Funded Amount,Total Amount Received,MTD Total Amount Received
PMTD Total Amount Received,Average Interest Rate,Average DTI,MTD Avgerage DTI,PMTD Average DTI


select count(id) as total_loan_applications from financial_loan;

select count(id) as MTD_total_loan_applications from financial_loan
where month(issue_date)=12 and year(issue_date)=2021

SELECT COUNT(id) AS PMTD_total_loan_Applications FROM financial_loan
WHERE MONTH(issue_date) = 11

SELECT SUM(loan_amount) AS total_Funded_Amount FROM financial_loan

SELECT SUM(loan_amount) AS MTD_total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 12

SELECT SUM(loan_amount) AS PMTD_total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 11

SELECT SUM(total_payment) AS total_Amount_Collected FROM financial_loan

SELECT SUM(total_payment) AS MTD_total_Amount_Collected FROM financial_loan
WHERE MONTH(issue_date) = 12

SELECT SUM(total_payment) AS PMTD_total_Amount_Collected FROM financial_loan
WHERE MONTH(issue_date) = 11

SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM financial_loan

SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM financial_loan
WHERE MONTH(issue_date) = 12

SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM financial_loan
WHERE MONTH(issue_date) = 11

SELECT AVG(dti)*100 AS Avg_DTI FROM financial_loan

SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 12

SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 11

# GOOD LOAN ISSUED 

SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM financial_loan

SELECT COUNT(id) AS Good_Loan_Applications FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


# BAD LOAN ISSUED

SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM financial_loan

SELECT COUNT(id) AS Bad_Loan_Applications FROM financial_loan
WHERE loan_status = 'Charged Off'

SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM financial_loan
WHERE loan_status = 'Charged Off'

SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM financial_loan
WHERE loan_status = 'Charged Off'


SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM financial_loan
    GROUP BY loan_status

 SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

 SELECT 
	home_ownership, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY home_ownership

SELECT address_state, 
       SUM(total_payment) AS total_amount
FROM financial_loan
GROUP BY address_state
ORDER BY total_amount DESC;


SELECT purpose, 
       COUNT(*) AS total_loans
FROM financial_loan
GROUP BY purpose
ORDER BY total_loans DESC;
SELECT address_state, 
       COUNT(*) AS total_loans
FROM financial_loan
GROUP BY address_state
HAVING COUNT(*) > 50
ORDER BY total_loans DESC;



SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state


SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term

SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY purpose


SELECT MONTH(issue_date) AS month,
       SUM(loan_amount) AS total_funded
FROM financial_loan
GROUP BY MONTH(issue_date)
ORDER BY month;


SELECT TOP 10 *
FROM financial_loan
WHERE int_rate > (
    SELECT AVG(int_rate) FROM financial_loan
)
ORDER BY int_rate DESC;


SELECT  TOP 10 id, total_payment,
       DENSE_RANK() OVER (ORDER BY total_payment DESC) AS rank
FROM financial_loan;

















