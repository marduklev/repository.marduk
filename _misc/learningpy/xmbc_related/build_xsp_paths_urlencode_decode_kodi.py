# -*- coding: utf-8 -*-
import urllib.parse
import webbrowser

# pip install inquirer
import inquirer


def options(option_value,xsp_type=None,field=None):
    # https://github.com/xbmc/xbmc/blob/master/xbmc/playlists/SmartPlayList.cpp
    if option_value == 'Choose Method':
        list = ['encode', 'decode']
    
    if option_value == 'xsp_type':
        list = ['songs', 'albums', 'artists', 'movies', 'tvshows', 'episodes', 'musicvideos', 'mixed']
    
    elif option_value == 'match':
        list = ['and', 'or']
    
    elif option_value == 'field':
        if xsp_type == 'songs':
            list = ['Genre', 'Source', 'Album', 'Artist', 'AlbumArtist', 'Title', 'Year', 'Time', 'TrackNumber', 'Filename', 'Path', 'Playcount', 'LastPlayed', 'Rating', 'UserRating', 'Comment', 'Moods']
        elif xsp_type ==  'albums':
            list = ['Genre', 'Source', 'Album', 'Artist', 'AlbumArtist', 'Year', 'Review', 'Themes', 'Moods', 'Styles', 'Compilation', 'AlbumType', 'MusicLabel', 'Rating', 'UserRating', 'Playcount', 'LastPlayed', 'Path']
        elif xsp_type ==  'artists':
            list = ['Artist', 'Source', 'Genre', 'Moods', 'Styles', 'Instruments', 'Biography', 'ArtistType', 'Gender', 'Disambiguation', 'Born', 'BandFormed', 'Disbanded', 'Died', 'Role', 'Path']
        elif xsp_type ==  'tvshows':
            list = ['Title', 'OriginalTitle', 'Plot', 'TvShowStatus', 'Votes', 'Rating', 'UserRating', 'Year', 'Genre', 'Director', 'Actor', 'NumberOfEpisodes', 'NumberOfWatchedEpisodes', 'Playcount', 'Path', 'Studio', 'MPAA', 'DateAdded', 'LastPlayed', 'InProgress', 'Tag']
        elif xsp_type ==  'episodes':
            list = ['Title', 'TvShowTitle', 'OriginalTitle', 'Plot', 'Votes', 'Rating', 'UserRating', 'Time', 'Writer', 'AirDate', 'Playcount', 'LastPlayed', 'InProgress', 'Genre', 'Year', 'Premiered', 'Director', 'Actor', 'EpisodeNumber', 'Season', 'Filename', 'Path', 'Studio', 'Mpaa', 'DateAdded', 'Tag', 'VideoResolution', 'AudioChannels', 'AudioCount', 'SubtitleCount', 'VideoCodec', 'AudioCodec', 'AudioLanguage', 'SubtitleLanguage', 'VideoAspectRatio']
        elif xsp_type ==  'movies':
            list = ['Title', 'OriginalTitle', 'Plot', 'PlotOutline', 'Tagline', 'Votes', 'Rating', 'UserRating', 'Time', 'Writer', 'Playcount', 'LastPlayed', 'InProgress', 'Genre', 'Country', 'Year', 'Premiered', 'Director', 'Actor', 'Mpaa', 'Top250', 'Studio', 'Trailer', 'Filename', 'Path', 'Set', 'Tag', 'DateAdded', 'VideoResolution', 'AudioChannels', 'AudioCount', 'SubtitleCount', 'VideoCodec', 'AudioCodec', 'AudioLanguage', 'SubtitleLanguage', 'VideoAspectRatio']
        elif xsp_type ==  'musicvideos':
            list = ['Title', 'Genre', 'Album', 'Year', 'Artist', 'Filename', 'Path', 'Playcount', 'LastPlayed', 'Rating', 'UserRating', 'Time', 'Director', 'Studio', 'Plot', 'Tag', 'DateAdded', 'VideoResolution', 'AudioChannels', 'AudioCount', 'SubtitleCount', 'VideoCodec', 'AudioCodec', 'AudioLanguage', 'SubtitleLanguage', 'VideoAspectRatio']
        else:
            list = ['Playlist', 'VirtualFolder']

    elif option_value == 'operator':
        list = ['contains', 'doesnotcontain', 'is', 'isnot', 'startswith', 'endswith', 'lessthan', 'greaterthan', 'after', 'before']
        if field == 'date':
            # untested
            list.extend(['inthelast', 'notinthelast'])
    
    if option_value == 'Do You wanna add another Rule':
        list = ['yes', 'no']
    
    # main operand, result = {'option_value': 'RESULT STRING'}
    questions = [
        inquirer.List
           (
            option_value,
              message=f"choose {option_value}",
              choices=list,
           ),
    ]
    
    answer_dict = inquirer.prompt(questions)
    
    ## convert n override
    option_value = answer_dict[option_value]
    # test print('\n','options END', option_value,'\n\n') 
    
    
    
    return option_value

def writeopenfile(method,source,result,url=None):
    lines = ['source:', source,' ','result :', result]
    with open('urlencode_decode_kodi_xsp_.txt', 'w') as f:
        for line in lines:
            f.write(line)
            f.write('\n')
    
    if method == 'encode':
        # append = ['\n','Kodi Content Tag', url]
        with open('urlencode_decode_kodi_xsp_.txt', 'a') as f:
           # f.writelines('\n'.join(append))
           f.writelines('\n'.join(['\n','experimental Kodi xml Content Tag', '<content>', url,'</content>']))
    
    webbrowser.open("urlencode_decode_kodi_xsp_.txt")
    
    return

def add_rules(xsp_type,xsp_rules,num_rules=2):
    # num_rules just inner indexing 
    seperator = ','
    field = options("field", xsp_type)
    operator = options("operator", xsp_type, field)
    field_value = input("enter the field value to operate:")
    
    new_rule = '{"field":"%s","operator":"%s","value":["%s"]}' % (field,operator,field_value)
    
    xsp_rules = xsp_rules + seperator + new_rule
    
    #  inner_loop = input("like to add another rule?? type [y] if you're d'accord:")
    inner_loop = options("Do You wanna add another Rule")
    
    if inner_loop == 'yes':
        num_rules = num_rules + 1
        # print(
            # 'fixed content is=:"', xsp_type,'"\n',
            # 'current rules are=:"', xsp_rules,'"\n',
            # 'start set rule number:"', num_rules,'"\n'
            # )
        xsp_rules = add_rules(xsp_type,xsp_rules,num_rules)
    
    return xsp_rules

def main():
    
    # method = input("encode or decode:")
    method =  options("Choose Method")
    
    # use numpad
    if method == 'encode':
        xsp_type = options("xsp_type")
        match = options("match")
        field = options("field", xsp_type)
        operator = options("operator", xsp_type, field)
        field_value = input("enter the field value to operate:")
        
        xsp_rules = '{"field":"%s","operator":"%s","value":["%s"]}' % (field,operator,field_value)
        
        # add rule subr
        # get_newrule = input('like to add another rule?? :')
        get_newrule = options("Do You wanna add another Rule")
        
        if get_newrule == 'yes':
            xsp_rule = xsp_rules
            xsp_rules = add_rules(xsp_type,xsp_rule)
        
        # example* source = 
        #    *  '{"rules":{"and":[{"field":"%s","operator":"%s","value":["%s"]}]},"type":"%s"}' % (field,operator,field_value,xsp_type)
        #    *  '{"rules":{"and":[{"field":"actor","operator":"contains","value":["$VAR[videoinfo_cast_container_id]"]},{"field":"title","operator":"isnot","value":["$INFO[Window(home).Property(EncodedTitle)]"]}]},"type":"movies"}'
        source = '{"rules":{"%s":[%s]},"type":"%s"}' % (match,xsp_rules,xsp_type)
        
        result = urllib.parse.quote(source.encode())
        
        
        # experimental : set db_url_root_path 
        if xsp_type == 'movies' or xsp_type == 'tvshows' or xsp_type == 'episodes' or xsp_type == 'musicvideos' or xsp_type == 'videos':
            db = 'videodb'
        else:
            db = 'musicdb'
        # else: files\\ ??
        
        if xsp_type == 'movies' or xsp_type == 'tvshows' or xsp_type == 'musicvideos':
            db_url_root_path = "%s://%s/titles/?xsp=" % (db,xsp_type)
        
        elif xsp_type == 'episodes':
            db_url_root_path = f"{db}://tvshows/titles/-1/-1/?xsp="
        
        else:
            db_url_root_path = "%sdb://%s/?xsp=" % (db,xsp_type)
        
        url = db_url_root_path + result
        print(' source \n', source,'\n\n result \n', result,'\n\n full_encodedpath: \n<content>\n', url,'\n</content>')
        
        writeopenfile(method,source,result,url)
        
    # decode
    elif method == 'decode':
        # example source = '%7B%22rules%22%3A%7B%22and%22%3A%5B%7B%22field%22%3A%22actor%22%2C%22operator%22%3A%22is%22%2C%22value%22%3A%5B%22christian%20bale%22%5D%7D%5D%7D%2C%22type%22%3A%22movies%22%7D'
        source = input("Copy Paste percent encode URL :\n")
        result = urllib.parse.unquote(source)
        
        print(' source \n',source,'\n\n result: \n', result)
        writeopenfile(method,source,result)
        
    else:
        print(' Not possible ')
        
if __name__ == '__main__':
    main()