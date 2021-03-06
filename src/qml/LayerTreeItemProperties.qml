import QtQuick 2.12

import org.qgis 1.0
import org.qfield 1.0

import "ui"

LayerTreeItemProperties {
  property var layerTree
  property var index
  property var panToLayerButtonText

    property var trackingButtonVisible: isTrackingButtonVisible()
    property var trackingButtonBgColor
    property var trackingButtonText

  x: (parent.width - width) / 2
  y: (parent.height - height) / 2

  onIndexChanged: {
    itemVisible = layerTree.data(index, FlatLayerTreeModel.Visible)
    title = qsTr("%1 : Properties and Functions").arg(layerTree.data(index, 0))
    panToLayerButtonText = qsTr( "Zoom to layer" )
    trackingButtonVisible = isTrackingButtonVisible()
    trackingButtonText = trackingModel.layerInTracking( layerTree.data(index, FlatLayerTreeModel.VectorLayerPointer) ) ? qsTr('Stop tracking') : qsTr('Start tracking')
  }

  onItemVisibleChanged: {
    layerTree.setData(index, itemVisible, FlatLayerTreeModel.Visible);
  }

  onPanToLayerButtonClicked: {
    mapCanvas.mapSettings.setCenterToLayer( layerTree.data( index, FlatLayerTreeModel.MapLayerPointer ) )
  }

  onTrackingButtonClicked: {
      //start track
      if( trackingModel.layerInTracking( layerTree.data(index, FlatLayerTreeModel.VectorLayerPointer) ) ) {
          trackingModel.stopTracker(layerTree.data(index, FlatLayerTreeModel.VectorLayerPointer));
          displayToast( qsTr( 'Track on layer %1 stopped' ).arg( layerTree.data(index, FlatLayerTreeModel.VectorLayerPointer).name  ) )
      }else{
          trackingModel.createTracker(layerTree.data(index, FlatLayerTreeModel.VectorLayerPointer), itemVisible);
      }
      close()
  }

  function isTrackingButtonVisible() {
    return layerTree.data(index, FlatLayerTreeModel.Type) === 'layer'
        && layerTree.data(index, FlatLayerTreeModel.Trackable)
        && positionSource.active
  }
}
