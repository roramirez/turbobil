module ActiveAdmin
  module Views
    class IndexAsTable < ActiveAdmin::Component
      #idea from http://amolnpujari.wordpress.com/2013/10/23/activeadmin-cool-tweaks/, thanks!
      def editable_text_column id, path, val, attr

        val = "&nbsp;" if val.blank?

        html = %{
                  <div  id='editable_text_column_#{id}'
                        class='editable_text_column'
                        ondblclick='admin.editable_text_column_do(this)' >
                        #{val}
                   </div>

                   <input
                      data-path='#{path}'
                      data-attr='#{attr}'
                      data-resource-id='#{id}'
                      class='editable_text_column admin-editable'
                      id='editable_text_column_#{id}'

                      style='display:none;' />
              }
        html.html_safe
      end


      def edit_rate_customer resource, val
        id = '%s_%s' % [resource.route_id, resource.id]
        path = 'price_customers/%s/%s/update_rate' % [resource.route_id, resource.id]
        editable_text_column id, path, val, 'value'
      end
    end
  end
end
