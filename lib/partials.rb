module Sinatra
  module Templates
    module Partials
      def partial(template, *args)
        options = args.extract_options!
        options.merge!(:layout => false)
        path = template.to_s.split(File::SEPARATOR)
        object = path[-1].to_sym
        path[-1] = "_#{path[-1]}"
        template = File.join(path).to_sym
        if collection = options.delete(:collection)
          collection.inject([]) do |buffer, member|
              buffer << erb(template, options.merge(:layout => false, :locals => {object => member}))
          end.join("\n")
        else
          erb(template, options)
        end
      end
    end
  end
end
