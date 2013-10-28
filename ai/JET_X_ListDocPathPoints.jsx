// Creates a textFrame containing coordinates for all pathItem anchors in the document,
// Coordinate formatting is per Jeff Grossman post in AI forum (spaces and third value).
// Coordintates are delimited by bar (|) characters.
if ( app.documents.length > 0 ) {
	var docRef = app.activeDocument;
	var containerPath=docRef.pathItems.rectangle(docRef.height,0,docRef.width,docRef.height);
	containerPath.zOrderPosition=0;
	var textRef=docRef.textFrames.areaText(containerPath);
	textRef.contents="";
	var pathRefs=docRef.pathItems;
	var pathCount=pathRefs.length;
	var scaleFactor=prompt("Native Illustrator coordinates are measured in points (1/72\"). If you would like a different unit of measure, enter an appropriate divisor:",1);
	for ( i = pathCount-1; i >= 0 ; i-- ) {
		var currPath=pathRefs[i];
		var pointRefs=currPath.pathPoints;
		var pointCount=pointRefs.length;
		//textRef.contents+= 'new path\n';

		// dernier path, print coordonnée debut et fin du path
		if(i==0){
			for(p=0;p<pointCount;p++){
				var currAnchor=currPath.pathPoints[p].anchor;
				var currAnchorVal=(Math.round(currAnchor[0])/scaleFactor)+", "+(Math.round(currAnchor[1])/scaleFactor)+" \n";
				textRef.contents+=currAnchorVal;
			}
		} else { // pas dernier point, print 1e coord only
			var currAnchor=currPath.pathPoints[0].anchor;
			var currAnchorVal=(Math.round(currAnchor[0])/scaleFactor)+", "+(Math.round(currAnchor[1])/scaleFactor)+" \n";
			textRef.contents+=currAnchorVal;
		}
	//var lastAnchorVal=(Math.round(firstAnchor[0])/scaleFactor)+" "+(Math.round(firstAnchor[1])/scaleFactor)+" 0|";
	//textRef.contents+=lastAnchorVal;
	}
}