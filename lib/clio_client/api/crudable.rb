module ClioClient
  module Api
    module Crudable

      def new(params = {})
        data_item(params)
      end

      def create(params = {})
        resource = params.is_a?(Array) ? create_plural(params) : create_singular(params)
      end

      def update(id, params = {})
        response = session.put("#{end_point_url}/#{id}", {singular_resource => params}.to_json)
        data_item(response[singular_resource])        
      end

      def destroy(id)
        session.delete("#{end_point_url}/#{id}", false)
      end

      private

      def create_singular(params)
        response = session.post(end_point_url, {singular_resource => params}.to_json)
        data_item(response[singular_resource])
      end

      def create_plural(params)
        response = session.post(end_point_url, {plural_resource => params}.to_json)
        response[plural_resource].map { |resource| data_item(resource) }
      end

    end
  end
end
