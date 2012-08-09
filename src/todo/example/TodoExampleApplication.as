package todo.example
{
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	import robotlegs.bender.framework.impl.Context;
	
	import spark.components.Application;
	
	import todo.example.config.AppConfiguration;
	
	public class TodoExampleApplication extends Application
	{
		protected var context: IContext;
		
		public function TodoExampleApplication()
		{
			super();
			
			addListeners();
		}
		
		/**
		 * Adds event listeners for the application.
		 */
		private function addListeners(): void
		{
			addEventListener(FlexEvent.PREINITIALIZE, preInitialize);
		}
		
		/**
		 * Handles the application preinitialization.
		 */
		private function preInitialize(e: FlexEvent): void
		{
			context = new Context()
				.extend(MVCSBundle)
				.configure(AppConfiguration, this);
			
			setLogLevel();
		}
		
		/**
		 * Sets the logLevel for the robotegs context.
		 */
		private function setLogLevel(): void
		{
			// setting the logLevel to WARN means that robotlegs
			// will also notify us about ERROR & FATAL.
			context.logLevel = LogLevel.WARN;
		}
	}
}