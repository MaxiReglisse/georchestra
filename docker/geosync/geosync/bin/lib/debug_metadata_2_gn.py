#!/usr/bin/python
# -*-coding:Utf-8 -*

import os
import sys

import owslib

from owslib.csw import CatalogueServiceWeb
csw = CatalogueServiceWeb('https://georchestra-docker.umrthema.univ-fcomte.fr/geonetwork/srv/fre/csw-publication', skip_caps=True, username='testadmin', password='testadmin')

from owslib.fes import PropertyIsEqualTo, PropertyIsLike
name_layer_gs="geosync-restreint:210_unknown_8bit__210_unknown_8bit"

myquery = PropertyIsEqualTo('csw:AnyText',name_layer_gs)
csw.getrecords2(constraints=[myquery], maxrecords=10)

