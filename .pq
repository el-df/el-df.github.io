[[[H‘ELDF’
]]]>>‘\/‘‘(Эта страница на русском\This page in Russian)’[./ru]’’



ELDF is an *‘e’xtra[[[/extremely]]] *‘l’ightweight *‘d’ata *‘f’ormat, an alternative to JSON[https://en.wikipedia.org/wiki/JSON ‘a very common data format’].

The aim of ELDF is to almost completely get rid of all visual noise of JSON (such as `{`, `}`, `"`, and `,`).


Examples:
T‘
H‘‘JSON’ ‘ELDF’’
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
<script src="./eldf.js"></script>
<textarea id="JSON" oninput="update()" style="font-family: 'Courier New'; width: 100%; height: 300px">Try it yourself!
(Just enter JSON here and see the resulting ELDF in the right column.)</textarea>
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
<textarea id="eldf2" oninput="update2()" style="font-family: 'Courier New'; width: 100%; height: 300px">Or enter ELDF here and see the corresponding JSON in the left column.</textarea>
’'
’’
’


Reference implementation in Python and JavaScript:
. ‘Project eldf at the Python Package Index’[https://pypi.org/project/eldf/]
. ‘Node.js Package’[https://npmjs.com/package/eldf]
. ‘Link to the main repository’[https://sourceforge.net/p/eldf/code/]


‘Discussion Forum’[https://sourceforge.net/p/eldf/discussion/]

Issues (bugs and feature requests):
. GitHub[https://github.com/el-df/eldf/issues]
. SourceForge.net[https://sourceforge.net/p/eldf/tickets/]


Articles on ELDF:
. ‘Article on habr.com (in Russian) titled ‘‘ELDF — новый текстовый формат данных (альтернатива JSON)’’’[https://habr.com/post/419361/]

[[[




><‘P‘https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png’[https://www.paypal.me/alextretyak]’
]]]