Class {
	#name : #PtyViewLibrary,
	#superclass : #Object,
	#classVars : [
		'Default'
	],
	#category : #'Presenty-Tools'
}

{ #category : #accessing }
PtyViewLibrary class >> default [ 
	^Default ifNil: [ Default := self subclasses anyOne new] 
]

{ #category : #accessing }
PtyViewLibrary class >> reset [ 
	<script>
	Default := nil
]
