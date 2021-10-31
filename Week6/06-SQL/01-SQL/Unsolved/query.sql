-- Select all the employees who were born between January 1, 1952 and December 31, 1955 and their titles and title date ranges
-- Order the results by emp_no
select employees.emp_no, first_name, last_name, title, from_date, to_date
from employees
join titles on employees.emp_no = titles.emp_no
where birth_date > '1952-01-01' and birth_date < '1955-12-31'
order by emp_no

-- Select only the current title for each employee

select emp_no,
first_name,
last_name,
title
from employees
join (	select emp_no,
			title
		from titles 
		join (	select emp_no,
	  				max
				from (select emp_no, max(to_date) from titles group by emp_no order by emp_no) sub1
	  		 ) sub2
		using (emp_no)
		where max = titles.to_date
		order by emp_no
	  ) sub3
	  using (emp_no)

-- join employees on employee.emp_no = titles.emp_no
select * 
from employees
join titles on employees.emp_no = titles.emp_no

-- Count the total number of employees about to retire by their current job title
select count(employees.emp_no),
title
from employees
join titles on employees.emp_no = titles.emp_no
where employees.birth_date > '1952-01-01' and employees.birth_date < '1955-12-31'
group by (title)

-- Count the total number of employees per department
select count(emp_no),
dept_no
from dept_emp
group by (dept_no)

-- Bonus: Find the highest salary per department and department manager
select * from dept_emp order by emp_no
select * from dept_manager
select * from salaries
select * from departments

select dept_no,
dept_name,
max_salary
from ( 	select 	dept_no,
	 			max(max_salary1) as max_salary
		from (select dept_emp.emp_no, dept_no, max(salary) as max_salary1 from salaries, dept_emp where dept_emp.emp_no = salaries.emp_no group by (dept_no, dept_emp.emp_no))  sub1
	 	group by (dept_no) ) sub2
join departments 
using (dept_no)
where dept_no = departments.dept_no
order by (dept_no)
		
select dept_no,
dept_name,
max_salary
from ( 	select 	dept_no,
	 			max(max_salary1) as max_salary
		from (select dept_manager.emp_no, dept_no, max(salary) as max_salary1 from salaries, dept_manager where dept_manager.emp_no = salaries.emp_no group by (dept_no, dept_manager.emp_no))  sub1
	 	group by (dept_no) ) sub2
join departments 
using (dept_no)
where dept_no = departments.dept_no
order by (dept_no)
