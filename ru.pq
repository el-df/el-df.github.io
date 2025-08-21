[[[H‘ELDF’
]]]>>‘\/‘‘(This page in English\Эта страница на английском)’[./..]’’



ELDF — это облегчённый формат данных (*‘e’xtra[[[/extremely]]] *‘l’ightweight *‘d’ata *‘f’ormat), альтернатива JSON[https://ru.wikipedia.org/wiki/JSON].
‘[[[Почему ]]]EL?’{
В то время как JSON — это lightweight data format {
>[https://json.org]:‘JSON (JavaScript Object Notation) is a lightweight dataC(6)‘-interchange’ format.’
}, ELDF — extra lightweight.
Также ELDF означает ELevenel[http://elevenel.org] Data Format.
}

Цель/назначение ELDF заключается в том, чтобы почти полностью избавиться от визуального шума[[[/мусора]]] формата JSON (такого как символы `{`, `}`, `"` и `,`).


Примеры:
Т‘
Н‘‘JSON’ ‘ELDF’’
‘‘#‘
{
    "personal": {
        "host": 50608,
        "subscription": {
            "type": "Basic",
            "bills": "monthly"
        },
        "path": "C:\\Users\\DNS\\Dropbox"
    }
}
’
’‘#‘

personal
    host = 50608
    subscription
        type = Basic
        bills = monthly
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
        document.getElementById('eldf').value = exports.to_eldf(JSON.parse(json));
    }
    catch (e) {
        let m = e.message.match(/ at position (\d+)/), msg;
        if (m == null)
            msg = 'Error: ' + e.message;
        else
            msg = form_error_message(json, Number(m[1]), JSON.stringify(e.message.replace(/ at position \d+/, '')).slice(1, -1));
        document.getElementById('eldf').value = msg;
    }
}
var exports = {};
</script>
<script src="../eldf.js"></script>
<textarea id="JSON" oninput="update()" style="font-family: 'Courier New'; width: 100%; height: 300px">Попробуйте сами!
(Просто введите JSON в это текстовое поле и сразу же получите результат в формате ELDF в правой колонке.)</textarea>
’'
’‘'‘
<textarea id="eldf" style="font-family: 'Courier New'; width: 100%; height: 300px" readonly></textarea>
’'
’’
‘‘'‘
<script>
function update2()
{
    let eldf = document.getElementById('eldf2').value;
    try {
        document.getElementById('JSON2').value = JSON.stringify(exports.parse(eldf), null, 4);
    }
    catch (e) {
        document.getElementById('JSON2').value = form_error_message(eldf, e.pos, 'Error: ' + e.message);
    }
}
</script>
<textarea id="JSON2" style="font-family: 'Courier New'; width: 100%; height: 300px" readonly></textarea>
’'
’‘'‘
<textarea id="eldf2" oninput="update2()" style="font-family: 'Courier New'; width: 100%; height: 300px">Или введите ELDF здесь, чтобы получить соответствующий JSON в левой колонке.</textarea>
’'
’’
’

T‘‘‘‘Яркие примеры’{
Рассмотрим следующий объект ELDF:
#‘
to_html
    type = function
    node
        function_arguments = [
        .   name = instr
        .   outer_name = output_html_document
            inner_name = ohd
        .   name = habr_html
        ]
’

Прямой перевод в JSON получается слишком многословным:
#‘
{
    "to_html": {
        "type": "function",
        "node": {
            "function_arguments": [
                {
                    "name": "instr"
                },
                {
                    "outer_name": "output_html_document",
                    "inner_name": "ohd"
                },
                {
                    "name": "habr_html"
                }
            ]
        }
    }
}
’

Этот JSON можно [[[сократить так]]]записать более коротко:
#‘
{
"to_html": {
    "type": "function",
    "node": {
        "function_arguments": [
            {"name": "instr"},
            {"outer_name": "output_html_document",
             "inner_name": "ohd"},
            {"name": "habr_html"}
        ]
    }
}
}
’

Но эта запись не так очевидна, как ELDF — похоже, что аргументов функции 4, а не 3.
}’’’


[[[Базовая/]Оригинальная[/Авторская] ]]Реализация на языках Python и JavaScript:
. ‘Страница проекта eldf в Python Package Index’[https://pypi.org/project/eldf/]
. ‘Node.js Package’[https://npmjs.com/package/eldf]
. ‘Ссылка на основной репозиторий’[https://sourceforge.net/p/eldf/code/]


‘Форум для обсуждения’[https://sourceforge.net/p/eldf/discussion/]

Сообщить об ошибке или предложить идею[[[предложение]]]:
. GitHub[https://github.com/el-df/eldf/issues]
. SourceForge.net[https://sourceforge.net/p/eldf/tickets/]


Статьи по ELDF:
. ‘Статья на Хабре ‘‘ELDF — новый текстовый формат данных (альтернатива JSON)’’’[https://habr.com/post/419361/]

[[[




><‘P‘https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png’[https://www.paypal.me/alextretyak]’
]]]