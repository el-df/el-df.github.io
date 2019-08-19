exports.to_thindf = function to_thindf(obj, indent = 4, level = 0, toplevel = true)
{
    function balance_pq_string(s)
    {
        let min_nesting_level = 0;
        let nesting_level = 0;
        for (let ch of s)
            switch (ch)
            {
            case "‘":
                nesting_level++;
                break;
            case "’":
                nesting_level--;
                min_nesting_level = Math.min(min_nesting_level, nesting_level);
                break;
            }
        nesting_level -= min_nesting_level;
        return "'".repeat(-min_nesting_level) + "‘".repeat(-min_nesting_level) + "‘" + s + "’" + "’".repeat(nesting_level) + "'".repeat(nesting_level);
    }

    function to_str(v, additional_prohibited_character = null)
    {
        if (typeof(v) == 'number')
            return v.toString();
        if (typeof(v) == 'boolean')
            return ({true:'1B', false:'0B'})[v];
        if (v == null)
            return 'N';
        console.assert(typeof(v) == 'string');
        if (v.length < 100 && v.includes("\n"))
            return JSON.stringify(v);
        if (v == '' || " \t[{'".includes(v[0]) || v.slice(0, 2) == '. ' || " \t".includes(v.slice(-1)) || v.includes('‘') || v.includes('’') || v.includes("\n") || v =='N' || v == 'Н' // }]
                || (additional_prohibited_character && v.includes(additional_prohibited_character)) || (v[0] >= '0' && v[0] <= '9') || (v[0] == '-' && v.slice(1, 2) >= '0' && v.slice(1, 2) <= '9'))
            return balance_pq_string(v);
        return v;
    }

    let r = '';
    if (obj instanceof Array) {
        if (toplevel) {
            if (obj.length == 0)
                return "[]\n";
            r += "[\n";
        }
        for (let [index, value] of obj.entries())
        {
            if (value instanceof Array) {
                r += ' '.repeat(indent * (level+1)) + '[';
                for (let [index2, subvalue] of value.entries())
                {
                    if (subvalue instanceof Object)
                        throw new Error('sorry, but this object can not be represented in thindf (element `' + JSON.stringify(subvalue) + '` of `' + JSON.stringify(value) + '`)');
                    r += to_str(subvalue, ',');
                    if (index2 < value.length-1)
                        r += ', ';
                }
                r += "]\n";
            }
            else if (value instanceof Object) {
                if (Object.keys(value).length == 0)
                    r += ' '.repeat(indent * level) + '.' + ' '.repeat(indent-1) + "{}\n";
                else {
                    r += ' '.repeat(indent * level) + '.' + to_thindf(value, indent, level+1, false).slice(indent * level + 1);
                    if (Object.keys(value).length > 2 && index < obj.length-1)
                        r += "\n";
                }
            }
            else
                r += ' '.repeat(indent * (level+1)) + to_str(value, '=') + "\n";
        }
        if (toplevel)
            r += "]\n";
    }
    else if (obj instanceof Object) {
        if (Object.keys(obj).length == 0 && toplevel)
            return "{}\n";
        let index = 0;
        for (let key in obj)
        {
            let value = obj[key];
            r += ' '.repeat(indent * level)
              +  to_str(key, '=');
            if (value instanceof Array) {
                if (value.length == 0)
                    r += " = []\n";
                else
                    r += " = [\n" + to_thindf(value, indent, level, false)
                      + ' '.repeat(indent * level) + "]\n";
            }
            else if (value instanceof Object)
                if (Object.keys(value).length == 0)
                    r += " = {}\n";
                else {
                    r += "\n" + to_thindf(value, indent, level+1, false);
                    if (Object.keys(value).length > 2 && index < Object.keys(obj).length-1)
                        r += "\n";
                }
            else // this is value
                r += ' = ' + to_str(value) + "\n";
            index++;
        }
    }

    return r;
}

ParseError = exports.ParseError = function(message, pos)
{
    this.message = message;
    this.pos = pos;
}

exports.parse = function (s)
{
    function find_ending_pair_quote(i)
    {
        console.assert(s[i] == "‘"); // ’
        const startqpos = i;
        for (let nesting_level = 0; ;i++) {
            if (i == s.length)
                throw new ParseError('unpaired left single quotation mark', startqpos);
            switch (s[i])
            {
            case "‘":
                nesting_level++;
                break;
            case "’":
                if (--nesting_level == 0)
                    return i;
                break;
            }
        }
    }

    function from_str(stop_characters = '')
    {
        const start = i;
        if (s[i] == '"') {
            for (i++; i < s.length; i++)
            {
                if (s[i] == "\\")
                    i++;
                else if (s[i] == '"') {
                    i++;
                    break;
                }
            }
            return JSON.parse(s.slice(start, i));
        }
        else if (s[i] == '‘') { // ’
            const endqpos = find_ending_pair_quote(i);
            for (i = endqpos + 1; i < s.length; i++)
                if (s[i] != "'")
                    break;
            const eat_right = i - (endqpos + 1); // количество кавычек, которые нужно съесть справа // ‘

            if (s.slice(endqpos-eat_right, endqpos+1) != '’'.repeat(eat_right+1))
                throw new ParseError('wrong ending of the raw string', endqpos);

            return s.slice(start+1, endqpos - eat_right);
        }
        else if (s[i] == "'") {
            for (i++; i < s.length; i++)
                if (s[i] != "'")
                    break;
            const eat_left = i - start; // количество кавычек, которые нужно съесть слева

            if (s.slice(i, i+eat_left+1) != '‘'.repeat(eat_left+1))
                throw new ParseError('wrong beginning of the raw string', start);

            const startqpos = i;
            const endqpos = find_ending_pair_quote(i);
            for (i = endqpos + 1; i < s.length; i++)
                if (s[i] != "'")
                    break;
            const eat_right = i - (endqpos + 1); // количество кавычек, которые нужно съесть справа

            if (s.slice(endqpos-eat_right, endqpos+1) != '’'.repeat(eat_right+1))
                throw new ParseError('wrong ending of the raw string', endqpos);

            return s.slice(startqpos + eat_left + 1, endqpos - eat_right);
        }
        else if ((s[i] >= '0' && s[i] <= '9') || (s[i] == '-' && s.slice(i+1, i+2) >= '0' && s.slice(i+1, i+2) <= '9')) {
            let is_float = false;
            for (i++; i < s.length;) {
                if (!(s[i] >= '0' && s[i] <= '9')) {
                    if ('.eE'.includes(s[i])) {
                        is_float = true;
                        i++;
                        if (i < s.length && '-+'.includes(s[i]))
                            i++;
                        continue;
                    }
                    else if ('BВ'.includes(s[i])) {
                        if (i - start != 1 || !'01'.includes(s[start]))
                            throw new ParseError('wrong value', start);
                        i++;
                        return {'0':false, '1':true}[s[start]];
                    }
                    break;
                }
                i++;
            }
            const ss = s.slice(start, i);
            return is_float ? parseFloat(ss) : parseInt(ss);
        }
        stop_characters += "\r\n";
        for (;i < s.length; i++)
            if (stop_characters.includes(s[i]))
                break;
        let t = i - 1;
        for (; t > start && " \t".includes(s[t]); t--);
        const ss = s.slice(start, t+1);
        if (ss == 'N' || ss == 'Н')
            return null;
        return ss;
    }

    let expected_an_indented_block = false;
    let indentation_levels = [];
    let obj_stack = [];
    let i = 0;

    if (s.length == 0)
        throw new ParseError('empty thindf is not allowed', 0);
    if (s[0] == '[') {
        console.assert(s.length >= 2);
        if (s[1] == ']') {
            console.assert(s.trimRight().length == 2);
            return [];
        }
        obj_stack.push([]);
        expected_an_indented_block = true;
        i = 1;
    }
    else {
        if (s.slice(0,2) == '{}') {
            console.assert(s.trimRight().length == 2);
            return {};
        }
        obj_stack.push({});
    }

    while (i < s.length) {
        let indentation_level = 0;
        for (; i < s.length; i++)
            if (s[i] == ' ')
                indentation_level++;
            else
                break;

        if (i == s.length) // end of source
            break;

        if ("\r\n".includes(s[i])) { // lines with only whitespace do not affect the indentation
            for (i++; i < s.length && "\r\n".includes(s[i]); i++);
            continue;
        }

        if (s.slice(i, i+2) == '. ') {
            indentation_level++;
            for (i++; i < s.length; i++)
                if (s[i] == ' ')
                    indentation_level++;
                else
                    break;
            console.assert(obj_stack[obj_stack.length-1] instanceof Array || (obj_stack[obj_stack.length-1] instanceof Object && obj_stack[obj_stack.length-2] instanceof Array));
            if (!(obj_stack[obj_stack.length-1] instanceof Array))
                obj_stack.pop();
            const new_dict = {};
            obj_stack[obj_stack.length-1].push(new_dict);
            obj_stack.push(new_dict);
        }
        const prev_indentation_level = indentation_levels.length ? indentation_levels[indentation_levels.length-1] : 0;

        if (expected_an_indented_block)
            if (!(indentation_level > prev_indentation_level))
                throw new ParseError('expected an indented block', i);

        if (indentation_level == prev_indentation_level)
            ;

        else if (indentation_level > prev_indentation_level) {
            if (!expected_an_indented_block)
                throw new ParseError('unexpected indent', i);
            expected_an_indented_block = false;
            indentation_levels.push(indentation_level);
            //obj_stack.push(null);
        }
        else { // [
            if (s[i] == ']') {
                console.assert(obj_stack[obj_stack.length-1] instanceof Array || (obj_stack[obj_stack.length-1] instanceof Object && obj_stack[obj_stack.length-2] instanceof Array));
                i++;
                indentation_levels.pop();
                if (obj_stack.length > 1)
                    if (obj_stack[obj_stack.length-1] instanceof Array || (obj_stack.length == 2 && obj_stack[0] instanceof Array))
                        obj_stack.pop();
                    else {
                        obj_stack.pop();
                        obj_stack.pop();
                    }
                continue;
            }
            while (true) {
                indentation_levels.pop();
                obj_stack.pop();
                const level = indentation_levels.length ? indentation_levels[indentation_levels.length-1] : 0;
                if (level == indentation_level)
                    break;
                if (level < indentation_level)
                    throw new ParseError('unindent does not match any outer indentation level', i);
            }
        }
        if (s[i] == '[') { // nested inline list
            console.assert(obj_stack[obj_stack.length-1] instanceof Array);
            let new_list = [];
            obj_stack[obj_stack.length-1].push(new_list);
            i++;
            while (true) {
                if (i == s.length)
                    throw new ParseError('unexpected end of source', i);
                if (s[i] == ']') {
                    i++;
                    break;
                } // [
                new_list.push(from_str(',]'));
                if (i < s.length)
                    if (s[i] == ',') {
                        for (i++; i < s.length && " \t".includes(s[i]); i++); // skip spaces after `,`
                    } // [[
                    else if (s[i] != ']')
                        throw new ParseError('expected `]`', i);
            }
            continue;
        }

        if (s.slice(i, i+2) == '{}') {
            //console.assert(obj_stack[obj_stack.length-1] instanceof Array);
            //obj_stack[obj_stack.length-1].push({})
            i += 2;
            continue;
        }
        const start = i;
        const key = from_str('=');
        for (; i < s.length && " \t".includes(s[i]); i++); // skip spaces after key

        if (i < s.length && s[i] == '=') {
            for (i++; i < s.length && " \t".includes(s[i]); i++); // skip spaces after `=`

            if (s.slice(i, i+2) == "[\r" || s.slice(i, i+2) == "[\n") { // ]]
                i += 2;
                expected_an_indented_block = true;
                const new_list = [];
                obj_stack[obj_stack.length-1][key] = new_list;
                obj_stack.push(new_list);
            }
            else {
                let value;
                if (s.slice(i, i+2) == '[]') {
                    i += 2;
                    value = [];
                }
                else if (s.slice(i, i+2) == '{}') {
                    i += 2;
                    value = {};
                }
                else
                    value = from_str();
                if (!(obj_stack[obj_stack.length-1] instanceof Object && !(obj_stack[obj_stack.length-1] instanceof Array)))
                    throw new ParseError('key/value pairs are allowed only inside dictionaries not lists', start);
                obj_stack[obj_stack.length-1][key] = value;
            }
        }
        else
            if (obj_stack[obj_stack.length-1] instanceof Array)
                obj_stack[obj_stack.length-1].push(key);
            else {
                expected_an_indented_block = true;
                const new_dict = {};
                obj_stack[obj_stack.length-1][key] = new_dict;
                obj_stack.push(new_dict);
            }
    }

    if (expected_an_indented_block)
        throw new ParseError('expected an indented block', i);

    while (indentation_levels.length) {
        indentation_levels.pop();
        obj_stack.pop();
    }
    console.assert(obj_stack.length == 1);
    return obj_stack[0];
}
