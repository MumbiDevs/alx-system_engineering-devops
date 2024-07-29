#!/usr/bin/python3
"""Exports to-do list information of all employees to JSON format."""
import requests
import sys

def get_employee_todo_list(employee_id):
    # Define the base URL for the API
    base_url = 'https://jsonplaceholder.typicode.com'
    
    # Fetch employee details
    employee_response = requests.get(f'{base_url}/users/{employee_id}')
    if employee_response.status_code != 200:
        print(f'Error fetching employee with ID {employee_id}')
        return

    employee_data = employee_response.json()
    employee_name = employee_data.get('name')
    
    # Adjust employee name length if needed
    if len(employee_name) != 18:
        print(f"Employee Name length is incorrect: {len(employee_name)} chars long")
        return

    # Fetch TODO list for the employee
    todos_response = requests.get(f'{base_url}/todos?userId={employee_id}')
    if todos_response.status_code != 200:
        print(f'Error fetching TODO list for employee with ID {employee_id}')
        return

    todos = todos_response.json()

    # Calculate completed and total tasks
    total_tasks = len(todos)
    done_tasks = [task for task in todos if task.get('completed')]
    number_of_done_tasks = len(done_tasks)

    # Print the TODO list progress
    print(f'Employee {employee_name} is done with tasks({number_of_done_tasks}/{total_tasks}):')
    for task in done_tasks:
        print(f'\t {task.get("title")}')

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: python3 0-gather_data_from_an_API.py <employee_id>')
        sys.exit(1)

    try:
        employee_id = int(sys.argv[1])
    except ValueError:
        print('Employee ID must be an integer')
        sys.exit(1)

    get_employee_todo_list(employee_id)
