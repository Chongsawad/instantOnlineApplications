/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
Ext.onReady(function(){
  var grid = new Ext.grid.GridPanel({
    columns: [
              {id:'company',header: 'Company', width: 160, sortable: true, dataIndex: ''},
              {header: 'Price', width: 75, sortable: true, renderer: 'usMoney', dataIndex: ''},
             ],
    height: 500,
    title: 'Site list'
  });
  grid.render('grid_example');
});