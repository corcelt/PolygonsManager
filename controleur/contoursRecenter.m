function contoursRecenter(~,~, obj)

polygonList = cell(1, length(obj.model.nameList));

h = waitbar(0,'D�but de la conversion');
for i = 1:length(polygonList)
    
    name = obj.model.nameList{i};
    
    poly = getPolygonFromName(obj.model, name);
    
    % recentre the polygon
    center  = polygonCentroid(poly);
    poly = bsxfun(@minus, poly, center);
    
    updatePolygon(obj.model.PolygonArray, getPolygonIndexFromName(obj.model, name), poly);
    waitbar(i / length(polygonList), h, ['process : ' name]);
end
close(h) 
ud = obj.handles.axes{1}.UserData;
if iscell(ud)
    polygonList = getPolygonsFromFactor(obj.model, ud{1});
    showContoursFactor(obj, polygonList);
else
    showContours(obj, getAllPolygons(obj.model.PolygonArray));
    if isa(obj.model.PolygonArray, 'PolarSignatureArray')
        displayPolarSignature(obj, obj.model.PolygonArray);
    end
end

end