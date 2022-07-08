# -*- coding: utf-8 -*-
import xbmc
import urllib.parse

def main():
    container_content = sys.argv[1]
    actor_name_id = 'bob odenkirk'
    
    exist_results = xbmc.executeJSONRPC(' {"jsonrpc": "2.0", "method": "VideoLibrary.Get%s", "params": { "filter": { "actor": "%s" } }, "id": "lib%s" }' % (container_content,actor_name_id,container_content)).find('"total":0')
    
    if exist_results == -1:
        if container_content == 'movies':
            db_url_root_path = 'videodb://movies/titles/?xsp='
        elif container_content == 'tvshows':
            db_url_root_path = 'videodb://tvshows/titles/?xsp='
        elif container_content == 'episodes':
            db_url_root_path = 'videodb://tvshows/titles/-1/-1/?xsp='
        decoded_xsp = '{"rules":{"and":[{"field":"actor","operator":"is","value":["%s"]}]},"type":"%s"}' % (actor_name_id,container_content)
        encoded_xsp = urllib.parse.quote(decoded_xsp.encode())
        
        url = db_url_root_path + encoded_xsp
        
        xbmc.executeJSONRPC('{"jsonrpc": "2.0", "method": "GUI.ActivateWindow", "params": { "window": "videos", "parameters": [ "%s" ] }, "id": 1}' % url)
    else:
        xbmc.executeJSONRPC('{"jsonrpc": "2.0", "method": "GUI.ShowNotification", "params": { "title": "sorry... ", "message": "no %s Items with %s found" }, "id": 1}' % (container_content,actor_name_id))

if __name__ == '__main__':
    main()