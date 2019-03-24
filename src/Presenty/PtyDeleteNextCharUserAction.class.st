Class {
	#name : #PtyDeleteNextCharUserAction,
	#superclass : #PtyTextEditorUserAction,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtyDeleteNextCharUserAction >> execute [

	presenter cursor deleteNextChar

	
]
