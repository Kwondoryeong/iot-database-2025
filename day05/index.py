
# 파이썬 웹앱(Flask)
## pip install Flask
from flask import Flask, render_template, request
import pymysql

# 변수 초기화
host = 'localhost' # or '127.0.0.1'
port = 3306
database = 'madang'
username = 'root'
password = '12345'

conflag = True # 접속상태

app = Flask(__name__) # 플라스크 웹앱실행

try:
    print('DB 연결 준비..')
    # 연결객체 conn 생성 
    # conn = pymysql.connect(host=host, user=username, passwd=password, db=database, port=port, charset='utf-8') # 파라미터
    conn = pymysql.connect(host=host, user=username, passwd=password, db=database, port=port) # 파라미터
    print('DB 연결 성공')
    conflag = True
except Exception as e:
    print(f'DB 연결 실패~!! {e}')
    conflag = False

cursor = conn.cursor()          # 커서 생성(MySQL의 커서와 동일한 기능)

@app.route('/') # routing decorator : 웹사이트 경로를 실행할 때 http://localhost:5000/
def index():
    query = '''SELECT bookid        
                    , bookname
                    , publisher
                    , price
                 FROM Book'''       # SQL 문장 준비 여러줄 문자열로 Workbench와 동일하게 사용
    res = cursor.execute(query)     # SQL 실행(1회 호출)
    data = cursor.fetchall()   # MySQL 데이터를 한번에 다 가져옴
    # templates 폴더에 있는 html을 데이터와 연결해서 렌더링 함.

    return render_template('booklist.html', book_list = data)

@app.route('/view') # http://localhost/5000/view?id=2
def getDetail():
    bookid = request.args.get('id')
    query = f'''SELECT bookid        
                    , bookname
                    , publisher
                    , price
                 FROM Book 
                WHERE bookid = '{bookid}'
            '''

    cursor.execute(query)

    data = cursor.fetchall()
    return render_template('bookview.html', book = data)

if __name__ == '__main__':
    app.run('localhost')

