#!/usr/bin/python3
""" Todo list progress for employee """

if __name__ == "__main__":
    import json
    import requests

    dict_user = {}
    req_f = (f'https://jsonplaceholder.typicode.com/users')
    users_req = requests.get(req_f)
    if users_req.status_code == 200:
        resp_user = users_req.json()
        all_users = []
        for user in resp_user:
            id = user.get("id")
            username = user.get("username")
            t = {id: username}
            all_users.append(t)
            # print(all_users)
        req_f = f'https://jsonplaceholder.typicode.com/todos'
        todos_req = requests.get(req_f)
        if todos_req.status_code == 200:
            resp_todos = todos_req.json()
            filename = f'todo_all_employees.json'
            with open(filename, mode='w') as f:
                todos_dict = {}
                for todo in resp_todos:
                    userId = todo.get("userId")
                    username = ""
                    for user in all_users:
                        key = list(user.keys())[0]
                        value = list(user.values())[0]
                        if key == userId:
                            username = value
                            break
                    t = {}
                    t["username"] = username
                    t["task"] = todo.get('title')
                    t["completed"] = todo.get('completed')
                    if not todos_dict.get(str(userId)):
                        todos_dict[str(userId)] = []
                    todos_dict[str(userId)].append(t)
                json.dump(todos_dict, f)
