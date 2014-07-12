api 地址暂定为

api2.sysujwxt.com/v1/

### 全局错误处理
- 400 Bad Request post的参数格式错误或者缺少
- 403 Session Expired session过期了，需要重新登陆
- 408 Request Timeout 学校的系统挂了等


Auth
----

    POST /signin     (post sno+password return account info)
    POST /signout

    

### error

- 401 Authentication Failed 密码错误（signin的时候有）


Book
----

    GET  /loan_books
    POST /renew (id+barcode 暂时不可用)

### error

暂时无

Search
------

    GET  /search_result_entry (返回set_number, no_entries）
    GET  /search_result （使用 set_number + set_entry，set_entry格式是 1-10 11-20 这样，从1开始）

### error

暂时无

cover redirect(weixin)
---------------------

    GET /cover (使用isbn作为参数)
    
测试用 shell 脚本
    
``` bash
#!/bin/bash

#URL="http://localhost:5000"
URL="http://api2.sysujwxt.com/v1"
curl -i -F 'sno=10389410' -F 'password=1111' 'http://api2.sysujwxt.com/v1/signin'

SESSION='"aS3Uda6h2niE4rcxju4PLt2oZq0=?_expires=STEzNzI2ODcxMjMKLg==&_permanent=STAxCi4=&id=VklEMTAwMDE4MTk1NgpwMQou&sno=VjEwMzg5NDEwCnAxCi4="'

# auth
#curl -i -F 'sno=10389410' -F 'password=1111' $URL/signin

# info api
#curl -i --cookie "session=$SESSION" $URL/info

# borrowed books
#curl -i --cookie "session=$SESSION" $URL/loan_books

#curl -i --cookie "session=$SESSION" -F "barcode=A6299235" $URL/renew

# search
#curl -i $URL/search_result_entry?name=c

curl -i "$URL/search_result?set_number=087599&set_entry=1-10"

#curl -i "$URL/status?doc_number=001017029"

```