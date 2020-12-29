Class {
	#name : #PtySettingsTest,
	#superclass : #TestCase,
	#category : #'Presenty-Tests-Tools'
}

{ #category : #tests }
PtySettingsTest >> testHasViewLibraryByDefault [

	| settings |
	settings := PtySettings new.
	
	settings viewLibrary should not be: nil.
	settings viewLibrary should be: PtyViewLibrary default
]
