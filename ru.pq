>>‘\/‘‘(This page in English\Эта страница на английском)’[./..]’’



thindf — это "тонкий" формат данных (thin data format), альтернатива JSON[https://ru.wikipedia.org/wiki/JSON].


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
        "habrahabr",
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
’


[[[Базовая/]Оригинальная[/Авторская] ]]Реализация на языке Python:
. ‘Страница проекта thindf в Python Package Index’[https://pypi.org/project/thindf/]
. ‘Ссылка на основной репозиторий’[https://bitbucket.org/thindf/thindf]


Статьи по thindf:
. ‘Статья на Хабре ‘‘thindf — новый текстовый формат данных (альтернатива JSON)’’’[--]





><‘P‘https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png’[https://www.paypal.me/alextretyak]’