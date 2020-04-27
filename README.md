# Pewlett-Hackard-Analysis
### Recommendation for the data set: 
Don't give columns the same name if they mean different things. For instance, from_date can mean from the date someone joined the company, joined a department, or became a certain role. There are quite a few tables having this column name but they mean differnt things, a situation which makes data analysis difficult.  
### Technical Analysis
    1. Problems to solve: We need to create a table to show a list of employees who are retirement-ready with emp_no, first_name, last_name, title, from_date, and salary columns in it. The table requires information from three tables and the combined dataset has duplicates that need to be removed in order to get a correct list of retirement-ready employees and a correct count. Then, we also need to create a table showing a list of employees who are eligible for a mentorship program as there are a lot of current employees reaching their retirement age. For the 2nd table, we need to inner join two tables to include emp_no, first_name, last_name, title, from_date, and to_date.
    2. Findings: 
       A. Technical Analysis Deliverable 1:
            (1) Number of employees who are retiring: 33118. (Table name: retirement_ready)
            (2) Number of retirement-ready employees by job title. (Table name: retirement_title_count) Based on the result, the company should work very hard on the mentorship program to fill the engineer related roles as there are a lot of them retiring, which can have a big impact on a technology company. 

                Engineer	2711
                Senior Engineer	13651
                Manager	2
                Assistant Engineer	251
                Staff	2022
                Senior Staff	12872
                Technique Leader	1609

        B. Technical Analysis Deliverable 2: Mentorship Eligiblity
            The number of employees who are eligible for the mentorship program is 1549. (Table name: eligible_mentorlist)

