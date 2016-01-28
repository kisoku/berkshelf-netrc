Berkshelf-netrc
===============

extend berkshelf to support chef universe endpoints with HTTP authentication
when a netrc entry for your berksfile source exists

== Usage

Add a netrc entry for your berkshelf source

```
machine universe.example.com
  login kisoku
  password nicepassword
```

Activate berkshelf-netrc before adding your source in your Berksfile

```
extension 'netrc'

source 'https://universe.example.com'
```
