Class {
	#name : #PtyUserActionConnectorTests,
	#superclass : #TestCase,
	#instVars : [
		'connector'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyUserActionConnectorTests >> setUp [
	super setUp.
	
	connector := PtyUserActionConnector new
]

{ #category : #tests }
PtyUserActionConnectorTests >> testConnectingActionToPresenter [ 

	[:activator1 :activator2 |
		connector activators add: activator1; add: activator2.
		
		[connector connectAction: #userAction to: #presenter]
			should strictly satisfy: 
		[activator1 presenter: #presenter; action: #userAction.
		activator1 hookupPresenter.
		activator2 presenter: #presenter; action: #userAction.
		activator2 hookupPresenter.]
	] runWithMocks 
]

{ #category : #tests }
PtyUserActionConnectorTests >> testHasEmptyActivatorsByDefault [

	connector activators should be isEmpty
]
