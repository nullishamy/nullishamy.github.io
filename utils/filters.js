import { DateTime } from 'luxon'

export default {
    dateToFormat: function (date, format) {
        return DateTime.fromJSDate(date, { zone: 'utc' }).toFormat(
            String(format)
        )
    },

    dateToISO: function (date) {
        return DateTime.fromJSDate(date, { zone: 'utc' }).toISO({
            includeOffset: false,
            suppressMilliseconds: true
        })
    },

    obfuscate: function (str) {
        const chars = []
        for (var i = str.length - 1; i >= 0; i--) {
            chars.unshift(['&#', str[i].charCodeAt(), ';'].join(''))
        }
        return chars.join('')
    },
    filterTagList: function (tags) {
        return (tags || []).filter(tag => ["all", "nav", "post", "posts"].indexOf(tag) === -1)
    },
    pageTags: function (tags) {
        const generalTags = ['all', 'nav', 'post', 'posts'];

        return tags
            .toString()
            .split(',')
            .filter((tag) => {
                return !generalTags.includes(tag);
            });
    },
    htmlDateString: function (dateObj) {
         return DateTime.fromJSDate(dateObj, { zone: 'utc' }).toFormat('yyyy-LL-dd')
    },
    excerpt: function (post) {
        const content = post.replace(/(<([^>]+)>)/gi, '');
        return content.substr(0, content.lastIndexOf(' ', 200)) + '...';
    },
    head: function (array, n) {
        if (n < 0) {
            return array.slice(n)
        }

        return array.slice(0, n)
    }
}
