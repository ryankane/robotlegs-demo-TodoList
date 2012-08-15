package todo.example.mediator
{
	import flash.display.DisplayObject;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import todo.example.domain.api.ITodoCollection;
	import todo.example.signal.CreateNewTodoSignal;
	import todo.example.ui.api.IPopup;
	import todo.example.view.api.ITodoFormView;
	
	public class TodoFormViewMediator extends Mediator
	{
		[Inject]
		public var createNewTodoSignal: CreateNewTodoSignal;
		
		[Inject]
		public var todoCollection: ITodoCollection;
		
		[Inject]
		public var popup: IPopup;
		
		[Inject]
		public var view: ITodoFormView;
		
		override public function initialize():void
		{
			view.cancelSignal.add(cancel);
			view.saveSignal.add(save);
			
			setTaskDescription();
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			view.dispose();
			
			popup = null;
			view = null;
		}
		
		/**
		 * Cancels the adding or modifying of 
		 * a todo.
		 */
		private function cancel(): void
		{
			remove();
		}
		
		/**
		 * Removes the form from the view.
		 */
		private function remove(): void
		{
			popup.remove(view);
		}
		
		/**
		 * Saves the entered task to the todo
		 * list.
		 */
		private function save(): void
		{
			createNewTodoSignal.dispatch(view.taskDescription);
			remove();
		}
		
		/**
		 * Sets the task description on the view if the user
		 * is modifying a todo item.
		 */
		private function setTaskDescription(): void
		{
			if (todoCollection.activeTodo)
				view.taskDescription = todoCollection.activeTodo.task;	
		}
	}
}