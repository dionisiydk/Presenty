Class {
	#name : #PtyUserActionTests,
	#superclass : #PtyUserActionTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #tests }
PtyUserActionTests >> testConnectingToPresenter [

	[:uiSettings :prototypesManager :prototype :userActionConnector |
	
		[action connectToPresenterBy: uiSettings]
			should strictly satisfy: 
		[uiSettings userActionPrototypes willReturn: prototypesManager.
		(prototypesManager prototypeFor: action) willReturn: prototype.
		prototype newInstance willReturn: userActionConnector.
		userActionConnector connectAction: action to: presenter].
	
		action connectorPrototype should be: prototype.
		action connector should be: userActionConnector.
		
	] runWithMocks 
]

{ #category : #tests }
PtyUserActionTests >> testConvertingToUserAction [

	action asUserAction should be: action
]

{ #category : #tests }
PtyUserActionTests >> testGettingBasePrototypeContexts [

	[	
		[action basePrototypeContexts should be: #result]
			should strictly satisfy: 
		[presenter basePrototypeContexts willReturn: #result].
			
	] runWithMocks 
]

{ #category : #running }
PtyUserActionTests >> userActionClass [ 
	^PtyUserAction
]
