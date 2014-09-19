class ActiveAdmin::Views::Pages::Base < Arbre::HTML::Document

  private
    #idea https://gist.github.com/MeetDom/985168
    # Renders the content for the footer
    def build_footer
      div :id => "footer" do
      para "Copyright &copy; 2014 #{link_to('Rodrigo Ramírez Norambuena', 'http://www.rodrigoramirez.com')}.<br/>
            Powered by #{link_to('Rails', 'http://rubyonrails.org/')} and #{link_to('Active Admin', 'http://www.activeadmin.info')} <br/>
            TurboBil is a Open Source project, #{link_to('get the code', 'https://github.com/roramirez/turbobil')}.
            ".html_safe
    end
  end

end
