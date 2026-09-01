Hier ist ein erster Entwurf eines JupyterLab-Plugins, das BlockPy in einer neuen Zelle nutzbar macht. Es erkennt „raw“-Zellen und wandelt diese um, sodass BlockPy in diesen Zellen integriert wird. Lass mich wissen, ob du Ergänzungen oder Änderungen benötigst!


``` python
// Importieren der notwendigen Module aus JupyterLab
import { JupyterFrontEnd, JupyterFrontEndPlugin } from '@jupyterlab/application';
import { INotebookTracker } from '@jupyterlab/notebook';
import { CodeMirrorEditor } from '@jupyterlab/codemirror';

// Plugin-Deklaration
const plugin: JupyterFrontEndPlugin<void> = {
  id: 'blockpy-codemirror-jupyterlab',
  autoStart: true,
  requires: [INotebookTracker],
  activate: (app: JupyterFrontEnd, tracker: INotebookTracker) => {
    console.log('BlockPy CodeMirror Plugin wird geladen');

    tracker.widgetAdded.connect((sender, notebookPanel) => {
      notebookPanel.context.ready.then(() => {
        const notebook = notebookPanel.content;

        notebook.widgets.forEach(cell => {
          if (cell.model.type === 'raw' && !cell.editorWidget.node.classList.contains('blockpy-cell')) {
            enhanceCellWithBlockPy(cell);
          }
        });

        notebook.model.cells.changed.connect((_, changes) => {
          if (changes.type === 'add') {
            changes.newValues.forEach(model => {
              const cell = notebook.widgets.find(widget => widget.model === model);
              if (cell && model.type === 'raw' && !cell.editorWidget.node.classList.contains('blockpy-cell')) {
                enhanceCellWithBlockPy(cell);
              }
            });
          }
        });
      });
    });
  }
};

function enhanceCellWithBlockPy(cell) {
  const editor = cell.editor as CodeMirrorEditor;
  editor.host.classList.add('blockpy-cell');

  // Hinzufügen einer BlockPy-Integration
  const blockPyContainer = document.createElement('div');
  blockPyContainer.classList.add('blockpy-container');
  editor.host.appendChild(blockPyContainer);

  // Initialisierung von BlockPy
  const blockPyInstance = new BlockPy(blockPyContainer, {
    // Konfigurationsoptionen für BlockPy
    enablePython: true,
    enableJavaScript: false,
  });

  // Synchronisation zwischen BlockPy und der Zelle
  blockPyInstance.onChange(code => {
    cell.model.value.text = code;
  });

  cell.model.value.changed.connect(() => {
    blockPyInstance.setCode(cell.model.value.text);
  });
}

export default plugin;

```
