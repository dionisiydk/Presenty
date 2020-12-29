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

{ #category : #testing }
PtyViewLibrary class >> isAbstract [ 
	^self = PtyViewLibrary
]

{ #category : #accessing }
PtyViewLibrary class >> reset [ 
	<script>
	Default := nil
]

{ #category : #views }
PtyViewLibrary >> labelView [
	self subclassResponsibility 
]

{ #category : #views }
PtyViewLibrary >> panelView [
	self subclassResponsibility 
]
