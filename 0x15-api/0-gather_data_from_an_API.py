#!/usr/bin/python3
"""Returns to-do list information for a given employee ID."""
import requests
import sys

def get_employee_todo_list(employee_id):
    # Base URL of the API
    base_url = "https://jsonplaceholder.typicode.com/"
    
    # Fetch user data
    user_response = requests.get(f"{base_url}users/{employee_id}")
    if user_response.status_code != 200:
        print("Error fetching user data")
        return
    user = user_response.json()
    employee_name = user.get("name")

    # Fetch TODO list data
    todos_response = requests.get(f"{base_url}todos", params={"userId": employee_id})
    if todos_response.status_code != 200:
        print("Error fetching TODO list")
        return
    todos = todos_response.json()

    # Calculate the number of completed tasks
    completed_tasks = [task.get("title") for task in todos if task.get("completed") is True]
    total_tasks = len(todos)
    number_of_done_tasks = len(completed_tasks)

    # Output the results in the required format
    print(f"Employee {employee_name} is done with tasks({number_of_done_tasks}/{total_tasks}):")
    for task in completed_tasks:
        print(f"\t {task}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 main_0.py <employee_id>")
        sys.exit(1)

    try:
        employee_id = int(sys.argv[1])
    except ValueError:
        print("Employee ID must be an integer")
        sys.exit(1)

    get_employee_todo_list(employee_id)
