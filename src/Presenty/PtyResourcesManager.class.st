Class {
	#name : #PtyResourcesManager,
	#superclass : #Object,
	#instVars : [
		'location'
	],
	#category : #'Presenty-Core'
}

{ #category : #accessing }
PtyResourcesManager >> checkExistenceOf: imageName [

	^(self location / imageName) exists
	
	
]

{ #category : #accessing }
PtyResourcesManager >> ensureLocation [

	self location ensureDirectory 
]

{ #category : #'initialize-release' }
PtyResourcesManager >> initialize [ 
	super initialize.
	
	location := FileLocator vmDirectory / 'images'
]

{ #category : #accessing }
PtyResourcesManager >> loadImage: imageName [

	| filepath |
	filepath := self location / imageName.
	
	filepath exists ifFalse: [^Form extent: 1 @ 1].
	
	^[ImageReadWriter formFromFileNamed: filepath fullName] ifError: [Form extent: 1 @ 1].
]

{ #category : #accessing }
PtyResourcesManager >> location [
	^ location
]

{ #category : #accessing }
PtyResourcesManager >> location: anObject [
	location := anObject
]
