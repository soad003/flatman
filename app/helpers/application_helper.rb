module ApplicationHelper

    def active_class_dashboard?(action)
      (controller.controller_name=='dashboard' && controller.action_name==action) ? 'active' : ''
    end

end
