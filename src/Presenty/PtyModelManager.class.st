Class {
	#name : #PtyModelManager,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#category : #'Presenty-Core'
}

{ #category : #initialize }
PtyModelManager >> initialize [
	super initialize.
	cache := WeakKeyDictionary new
]

{ #category : #removing }
PtyModelManager >> removeFromCache: objectArray [
	| key |
	self halt.
	key := objectArray first.
	cache removeKey: key ifAbsent: []
]

{ #category : #accessing }
PtyModelManager >> trackChangesOf: dataField [ 
	dataField toFinalizeSend: #removeFromCache: to: self with: { dataField }.
	^ cache at: dataField ifAbsent: [ cache at: dataField put: (PtyObjectTracker for: dataField) ]
]
