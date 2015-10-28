#!/usr/bin/env python
# Copyright 2015 Al Nikolov

import sys
import xml.etree.ElementTree

def 
namespaces = {
    'export': 'http://zakupki.gov.ru/oos/export/1', 
    'types': 'http://zakupki.gov.ru/oos/types/1',
}
for prefix, uri in namespaces.items():
    xml.etree.ElementTree.register_namespace(prefix, uri)

contractStatusCodes = {
    'E':  'active',
    'EC': 'terminated',
    'ET': 'terminated',
    'IN': 'terminated',
}

root = xml.etree.ElementTree.parse(sys.stdin).getroot()
contract = {
    'id': int(root.find('./export:contract/types:id').text), # Req
    'awardID': -1, # Req Stub
    'title': root.find('./export:contract/types:regNum').text, # Closest
    #'description': None, Miss
    'status': 

