Class {
	#name : #PtySettingsTests,
	#superclass : #TestCase,
	#category : #'Presenty-Tests-Tools'
}

{ #category : #tests }
PtySettingsTests >> testHasViewLibraryByDefault [

	| settings |
	settings := PtySettings new.
	
	settings viewLibrary should not be: nil.
	settings viewLibrary should be: PtyViewLibrary default
]
