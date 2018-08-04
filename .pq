>>‘\/‘‘(Эта страница на русском\This page in Russian)’[./ru]’’



thindf is a thin data format, an alternative to JSON[https://en.wikipedia.org/wiki/JSON].


Examples:
T‘
H‘‘JSON’ ‘thindf’’
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
‘‘'‘
<script>
function update()
{
    let json = document.getElementById('JSON').value;
    try {
        document.getElementById('thindf').value = exports.stringify(JSON.parse(json));
    }
    catch (e) {
        let m = e.message.match(/ at position (\d+)/), msg;
        if (m == null)
            msg = e.message;
        else {
            let pos = Number(m[1]);
            let next_line_pos = json.indexOf("\n", pos);
            if (next_line_pos == -1)
                next_line_pos = json.length;
            let prev_line_pos = json.lastIndexOf("\n", pos) + 1;
            msg = json.slice(0, next_line_pos) + "\n" + '-'.repeat(pos - prev_line_pos) + '^' + e.message.replace(/ at position \d+/, '') + json.slice(next_line_pos);
        }
        document.getElementById('thindf').value = msg;
    }
}
var exports = {};
</script>
<script src="https://bbcdn.githack.com/thindf/thindf/raw/default/thindf.js"></script>
<textarea id="JSON" oninput="update()" style="font-family: 'Courier New'; width: 100%; height: 300px">Try it yourself!
(Just enter JSON here and see the resulting thindf in the right column.)</textarea>
’'
’‘'‘
<textarea id="thindf" style="font-family: 'Courier New'; width: 100%; height: 300px" readonly></textarea>
’'
’’
’


Reference implementation in Python:
. ‘Project thindf at the Python Package Index’[https://pypi.org/project/thindf/]
. ‘Link to the main repository’[https://bitbucket.org/thindf/thindf]


Articles on thindf:
. ‘Article on habr.com (in Russian) titled ‘‘thindf — новый текстовый формат данных (альтернатива JSON)’’’[--]





><‘P‘https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png’[https://www.paypal.me/alextretyak]’