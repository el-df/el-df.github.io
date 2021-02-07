>>‘\/‘‘(This page in English\Эта страница на английском)’[./..]’’



thindf — это "тонкий" формат данных (thin data format), альтернатива JSON[https://ru.wikipedia.org/wiki/JSON ‘a very common data format’].

Цель/назначение thindf заключается в том, чтобы почти полностью избавиться от визуального шума формата JSON (такого как символы `{`, `}`, `"` и `,`).


Примеры:
Т‘
Н‘‘JSON’ ‘thindf’’
‘‘#‘
{
    "personal": {
        "host": 5060852864,
        "is_team": false,
        "subscription_type": "Basic",
        "path": "C:\\Users\\DNS\\Dropbox"
    }
}
’
’‘#‘

personal
    host = 5060852864
    is_team = 0B
    subscription_type = Basic
    path = C:\Users\DNS\Dropbox


’’’
‘‘#‘
{
    "added_words":
    [
        "plugin",
        "habrahabr"
    ],
    "font_size": 11
}
’’
‘#‘

added_words = [
    plugin
    habrahabr
]

font_size = 11

’’’
‘‘#‘
[
  {
    "userId": 1,
    "id": 1,
    "title": "delectus aut autem",
    "completed": false
  },
  {
    "userId": 1,
    "id": 2,
    "title": "quis ut nam facilis et officia qui",
    "completed": false
  }
]
’’‘#‘

[
.   userId = 1
    id = 1
    title = delectus aut autem
    completed = 0B

.   userId = 1
    id = 2
    title = quis ut nam facilis et officia qui
    completed = 0B
]


’’’
‘‘#‘
{
    "schema_version": "3.0.0",
    "packages": [
        {
            "name": "Django Lookup Snippets",
            "details": "https://github.com/icycandle/...",
            "releases": [
                {
                    "sublime_text": "*",
                    "tags": true
                }
            ]
        },
        {
            "name": "Django Manage Commands",
            "details": "https://github.com/vladimirnani/...",
            "labels": ["Django", "python", "web", "management"],
            "releases": [
                {
                    "sublime_text": "<3000",
                    "tags": "st2-"
                },
                {
                    "sublime_text": ">=3000",
                    "tags": "st3-"
                }
            ]
        }
    ]
}
’’
‘#‘

schema_version = ‘3.0.0’
packages = [
.   name = Django Lookup Snippets
    details = https://github.com/icycandle/...
    releases = [
    .   sublime_text = *
        tags = 1B
    ]

.   name = Django Manage Commands
    details = https://github.com/vladimirnani/...
    labels = [
        Django
        python
        web
        management
    ]
    releases = [
    .   sublime_text = <3000
        tags = st2-
    .   sublime_text = >=3000
        tags = st3-
    ]
]





’’’
‘‘#‘
[
    {"number": 0, "chapter": "Read Me First!"},
    {"number": 1, "chapter": "How Names Work"},
    ...
]
’’‘#‘
[
.   number = 0; chapter = Read Me First!
.   number = 1; chapter = How Names Work
    ...
]
’’’
‘‘'‘
<script>
function form_error_message(source, pos, message)
{
    let next_line_pos = source.indexOf("\n", pos);
    if (next_line_pos == -1)
        next_line_pos = source.length;
    let prev_line_pos = source.lastIndexOf("\n", pos - 1) + 1;
    return source.slice(0, next_line_pos) + "\n" + '-'.repeat(pos - prev_line_pos) + '^' + message + source.slice(next_line_pos);
}

function update()
{
    let json = document.getElementById('JSON').value;
    try {
        document.getElementById('thindf').value = exports.to_thindf(JSON.parse(json));
    }
    catch (e) {
        let m = e.message.match(/ at position (\d+)/), msg;
        if (m == null)
            msg = 'Error: ' + e.message;
        else
            msg = form_error_message(json, Number(m[1]), JSON.stringify(e.message.replace(/ at position \d+/, '')).slice(1, -1));
        document.getElementById('thindf').value = msg;
    }
}
var exports = {};
</script>
<script src="../thindf.js"></script>
<textarea id="JSON" oninput="update()" style="font-family: 'Courier New'; width: 100%; height: 300px">Попробуйте сами!
(Просто введите JSON в это текстовое поле и сразу же получите результат в формате thindf в правой колонке.)</textarea>
’'
’‘'‘
<textarea id="thindf" style="font-family: 'Courier New'; width: 100%; height: 300px" readonly></textarea>
’'
’’
‘‘'‘
<script>
function update2()
{
    let thindf = document.getElementById('thindf2').value;
    try {
        document.getElementById('JSON2').value = JSON.stringify(exports.parse(thindf), null, 4);
    }
    catch (e) {
        document.getElementById('JSON2').value = form_error_message(thindf, e.pos, 'Error: ' + e.message);
    }
}
</script>
<textarea id="JSON2" style="font-family: 'Courier New'; width: 100%; height: 300px" readonly></textarea>
’'
’‘'‘
<textarea id="thindf2" oninput="update2()" style="font-family: 'Courier New'; width: 100%; height: 300px">Или введите thindf здесь, чтобы получить соответствующий JSON в левой колонке.</textarea>
’'
’’
’


[[[Базовая/]Оригинальная[/Авторская] ]]Реализация на языках Python и JavaScript:
. ‘Страница проекта thindf в Python Package Index’[https://pypi.org/project/thindf/]
. ‘Node.js Package’[https://npmjs.com/package/thindf]
. ‘Ссылка на основной репозиторий’[https://sourceforge.net/p/thindf/code/ <- https://bitbucket.org/thindf/thindf]


Статьи по thindf:
. ‘Статья на Хабре ‘‘thindf — новый текстовый формат данных (альтернатива JSON)’’’[https://habr.com/post/419361/]





><‘P‘https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png’[https://www.paypal.me/alextretyak]’