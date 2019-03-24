Class {
	#name : #PtyImageLabel,
	#superclass : #ImageMorph,
	#instVars : [
		'labelName'
	],
	#category : #'Presenty-UI'
}

{ #category : #menu }
PtyImageLabel >> addCustomMenuItems: aCustomMenu hand: aHandMorph [

	super addCustomMenuItems: aCustomMenu hand: aHandMorph.
	self addContainerMenuItems: aCustomMenu 
]

{ #category : #accessing }
PtyImageLabel >> cleanupYourselfForPrototype [ 
	super cleanupYourselfForPrototype.
	self image: self class defaultForm 
]

{ #category : #accessing }
PtyImageLabel >> labelName [
	^ labelName
]

{ #category : #accessing }
PtyImageLabel >> labelName: anObject [
	labelName := anObject
]

{ #category : #accessing }
PtyImageLabel >> setCurrentTranslation [
	
	| filename translator |
	filename := UITheme current
		chooseFileNameIn: World
		title: 'Choose image file' translated
		extensions: #('png' 'bmp' 'jpg')
		path: self findBuildContext resourcesManager location fullName
		preview: true.
	filename ifNil: [^self].
	
	translator := self findBuildContext guide translator.
	translator addTranslation: filename for: labelName.
	self translateContentBy: translator
]

{ #category : #accessing }
PtyImageLabel >> translateContentBy: aTranslator [

	| imageName newImage |
	labelName ifNil: [^self].
	
	imageName := aTranslator translate: labelName.
	
	newImage := self findBuildContext resourcesManager loadImage: imageName.

	self image: newImage
	
]
