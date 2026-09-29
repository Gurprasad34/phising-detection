CREATE DATABASE phishing_analytics;

USE phishing_analytics;


-- Check total number of records
SELECT COUNT(*) AS total_records
FROM websites;

-- Website class distribution
SELECT
    CASE
        WHEN label = 1 THEN 'Phishing'
        ELSE 'Legitimate'
    END AS website_type,
    COUNT(*) AS website_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM websites), 2) AS percentage
FROM websites
GROUP BY label
ORDER BY label;


-- Average URL length by website type
SELECT
    CASE
        WHEN label = 1 THEN 'Phishing'
        ELSE 'Legitimate'
    END AS website_type,
    ROUND(AVG(URLLength), 2) AS avg_url_length,
    MIN(URLLength) AS min_url_length,
    MAX(URLLength) AS max_url_length
FROM websites
GROUP BY label;

-- Average domain length by website type
SELECT
    CASE
        WHEN label = 1 THEN 'Phishing'
        ELSE 'Legitimate'
    END AS website_type,
    ROUND(AVG(DomainLength), 2) AS avg_domain_length
FROM websites
GROUP BY label;

-- HTTPS usage by website type
SELECT
    CASE
        WHEN label = 1 THEN 'Phishing'
        ELSE 'Legitimate'
    END AS website_type,
    COUNT(*) AS total_websites,
    SUM(IsHTTPS = 1) AS https_websites,
    ROUND(SUM(IsHTTPS = 1) * 100.0 / COUNT(*), 2) AS https_percentage
FROM websites
GROUP BY label;

-- Percentage of websites containing password fields
SELECT
    CASE
        WHEN label = 1 THEN 'Phishing'
        ELSE 'Legitimate'
    END AS website_type,
    ROUND(AVG(HasPasswordField) * 100, 2) AS password_field_percentage
FROM websites
GROUP BY label;

--  Financial-related indicators
SELECT
    CASE
        WHEN label = 1 THEN 'Phishing'
        ELSE 'Legitimate'
    END AS website_type,
    ROUND(AVG(Bank) * 100, 2) AS bank_percentage,
    ROUND(AVG(Pay) * 100, 2) AS pay_percentage,
    ROUND(AVG(Crypto) * 100, 2) AS crypto_percentage
FROM websites
GROUP BY label;