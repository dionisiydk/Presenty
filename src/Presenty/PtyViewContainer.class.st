Class {
	#name : #PtyViewContainer,
	#superclass : #BorderedMorph,
	#instVars : [
		'announcer'
	],
	#category : #'Presenty-UI'
}

{ #category : #accessing }
PtyViewContainer >> addContainer [
	self add: PtyViewContainer new
]

{ #category : #menu }
PtyViewContainer >> addCustomMenuItems: aCustomMenu hand: aHandMorph [

	super addCustomMenuItems: aCustomMenu hand: aHandMorph.
	self addContainerMenuItems: aCustomMenu 
]

{ #category : #accessing }
PtyViewContainer >> addIcon [
	| form |
	form := UIManager default imageOpenIn: World.
	form ifNil: [^self].
	self add: (ImageMorph withForm: form)
]

{ #category : #accessing }
PtyViewContainer >> addImageLabel [
	
	| filename label |
	filename := UITheme current
		chooseFileNameIn: World
		title: 'Choose image file' translated
		extensions: #('png' 'bmp' 'jpg')
		path: self findBuildContext resourcesManager location fullName
		preview: true.
	filename ifNil: [^self].
	
	label := PtyImageLabel new.
	label labelName: filename.
	self add: label.
	self findBuildContext guide translateContentOf: label.
]

{ #category : #accessing }
PtyViewContainer >> addTextLabel [

	| labelName label |
	labelName := UIManager default request: 'Input label name'.
	labelName ifNil: [^self].
	labelName ifEmpty: [^self].
	
	label := PtyTextLabel new.
	label labelName: labelName.
	self findBuildContext guide translateContentOf: label.
	self add: label
]

{ #category : #accessing }
PtyViewContainer >> announcer [ 

	^announcer ifNil: [announcer := Announcer new]
]

{ #category : #accessing }
PtyViewContainer >> announcer: anAnnouncer [

	announcer := anAnnouncer
]

{ #category : #'event handling-override' }
PtyViewContainer >> bounds: aRectangle [

	| changed |
	changed := (aRectangle extent = self extent) not.
	
	super bounds: aRectangle.
	
	changed ifFalse: [^self].
	
	self announcer announce: PtyLayoutChanged
]

{ #category : #testing }
PtyViewContainer >> canHaveFillStyles [
	^true
]

{ #category : #copying }
PtyViewContainer >> cleanupYourselfForPrototype [ 
	super cleanupYourselfForPrototype.
	announcer := Announcer new.
]

{ #category : #accessing }
PtyViewContainer >> clear [
	self removeAllMorphs
]

{ #category : #copying }
PtyViewContainer >> collectOwnCopyPreventedResourcesTo: aCollection [ 
	super collectOwnCopyPreventedResourcesTo: aCollection.
	announcer ifNotNil: [aCollection add: announcer]
]

{ #category : #accessing }
PtyViewContainer >> computeVisibleCellCount: cellExtent [ 
	| cellsPerRow cellsPerColumn |

	cellsPerRow := self width - (self layoutInset asPoint x * 2) // (cellExtent x + (self cellInset asPoint x * 2)).
	cellsPerColumn := self height - 180 -  (self layoutInset asPoint y * 2) // (cellExtent y + (self cellInset asPoint y * 2)).
	^cellsPerColumn * cellsPerRow

]

{ #category : #'event handling-override' }
PtyViewContainer >> extent: aPoint [ 

	super extent: aPoint.
	
	self announcer announce: PtyLayoutChanged
]

{ #category : #accessing }
PtyViewContainer >> findPanelNamed: aString in: aMorph [
	| panel |
	
	aMorph submorphsDo: [:each | each externalName = aString ifTrue: [^each]].
	
	aMorph submorphsDo: [:each | panel := self findPanelNamed: aString in: each.
		panel ifNotNil: [^panel]
		].
	
	^nil
]

{ #category : #'event handling-override' }
PtyViewContainer >> handlesMouseDown: evt [

	| handler |
	(super handlesMouseDown: evt)
		ifTrue: [^true].
		
	handler := self firstOwnerSuchThat: [:m | 
		(m == self world) not and: [m handlesMouseDown: evt]].
	
	^handler isNil
]

{ #category : #testing }
PtyViewContainer >> handlesMouseWheel: evt [
	
	self eventHandler
		ifNotNil: [^self eventHandler handlesMouseWheel: evt].
		
	^false
]

{ #category : #initialization }
PtyViewContainer >> initialize [ 
	super initialize.
		
	self
		color: Color yellow;
		borderWidth: 3;
		borderColor: Color red;
		toggleCornerRounding;
		clipSubmorphs: true;
		changeTableLayout;
		listDirection: #leftToRight;
		"wrapDirection: #topToBottom;"
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		listCentering: #center;
		wrapCentering: #center;
		layoutInset: 0@0
		
		
]

{ #category : #'event handling-override' }
PtyViewContainer >> layoutChanged [ 

	super layoutChanged.
	
	"self announcer announce: PtyLayoutChanged"
]

{ #category : #accessing }
PtyViewContainer >> migrateNeighbors [

	| neighbors |
	neighbors := self owner submorphs select: [:each | each ~= self & each hasBuildContext not].
	neighbors do: [:each | 
		each disableTableLayout: false.
		self add: each].
]

{ #category : #testing }
PtyViewContainer >> mouseWheel: event [ 
	"Handle a mouseWheel event."
	self eventHandler
		ifNotNil: [self eventHandler mouseWheel: event fromMorph: self]

]

{ #category : #accessing }
PtyViewContainer >> on: eventName send: selector to: recipient [
	self eventHandler ifNil: [self eventHandler: PtyEventHandler new].
	^super on: eventName send: selector to: recipient
]

{ #category : #accessing }
PtyViewContainer >> panelNamed: aString [

	| panel |
	
	panel := self findPanelNamed: aString in: self.
	panel ifNotNil: [^panel].
		
	panel := PtyViewContainer new.
	panel name: aString.
	self add: panel.
	
	^panel
]

{ #category : #accessing }
PtyViewContainer >> useBackgroundFile [
	
	| filename |
	filename := UITheme current
		chooseFileNameIn: World
		title: 'Choose image file' translated
		extensions: #('png' 'bmp' 'jpg')
		path: self findBuildContext resourcesManager location fullName
		preview: true.
	filename ifNil: [^self].
	
	self ptyBackgroundFile: filename.
]
