#!/usr/bin/python3
""" Todo list progress for employee """

if __name__ == "__main__":
    import csv
    import requests
    import sys

    id = sys.argv[1]
    if id:
        try:
            id = int(id)
            req_f = f'https://jsonplaceholder.typicode.com/users/{id}'
            emp_req = requests.get(req_f)
            if emp_req.status_code == 200:
                resp_emp = emp_req.json()
                name = resp_emp.get('name')
                username = resp_emp.get('username')
                req_f = (
                    f'https://jsonplaceholder.typicode.com/todos?userId={id}')
                todos_req = requests.get(req_f)
                if todos_req.status_code == 200:
                    resp_todos = todos_req.json()
                    filename = f'{id}.csv'
                    with open(filename, mode='w') as csvfile:
                        writer = csv.writer(csvfile,
                                            quoting=csv.QUOTE_ALL)
                        # writer.writeheader()
                        for todo in resp_todos:
                            completed = todo.get('completed')
                            title = todo.get('title')
                            writer.writerow([str(id),
                                             str(username),
                                             str(completed),
                                             str(title)])
        except ValueError:
            pass
