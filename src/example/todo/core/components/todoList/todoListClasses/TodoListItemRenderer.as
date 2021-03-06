package example.todo.core.components.todoList.todoListClasses
{
	import flash.events.MouseEvent;
	
	import example.todo.core.domain.Todo;

	public class TodoListItemRenderer extends TodoListItemRendererBase
	{
		public function TodoListItemRenderer()
		{
			super();
		}
		
		override protected function stateChanged(oldState:String, newState:String, recursive:Boolean):void
		{
			(newState == "selected") ? addListeners() : removeListeners();
		}
		
		/**
		 * Adds click listeners to the modify & 
		 * complete buttons.
		 */
		private function addListeners(): void
		{
			completeButton.addEventListener(MouseEvent.CLICK, complete);
			modifyButton.addEventListener(MouseEvent.CLICK, modify);
		}
		
		/**
		 * Handles the user wanting to mark a todo task as
		 * complete by dispatching an event to notify the
		 * rest of the application.
		 */
		private function complete(e: MouseEvent): void
		{
			dispatchEvent(new TodoListEvent(TodoListEvent.COMPLETE, data as Todo));
		}
		
		/**
		 * Handles the user wanting to modify a todo by
		 * dispatching an event to notify the rest of
		 * the application.
		 */
		private function modify(e: MouseEvent): void
		{
			dispatchEvent(new TodoListEvent(TodoListEvent.MODIFY, data as Todo));
		}
		
		/**
		 * Removes the click listeners from the modify
		 * & complete buttons.
		 */
		private function removeListeners(): void
		{
			if (completeButton)
				completeButton.removeEventListener(MouseEvent.CLICK, complete);
			
			if (modifyButton)
				modifyButton.addEventListener(MouseEvent.CLICK, modify);
		}
	}
}