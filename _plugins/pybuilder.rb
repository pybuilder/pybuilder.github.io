# frozen_string_literal: true

module Jekyll
  module PyBuilder
    module Filter
      include Jekyll::Filters::URLFilters

      def abs_canonical_url(url)
        absolute_url(url).to_s.gsub(%r!/index\.html$!, "/").gsub(%r!\.html$!, "")
      end

      def rel_canonical_url(url)
        relative_url(url).to_s.gsub(%r!/index\.html$!, "/").gsub(%r!\.html$!, "")
      end

      def group_by_ext(values, field)
        result = []
        values.each {|value|
            field_vals = value[field]
            field_vals = [field_vals] unless field_vals.is_a?(Array)

            field_vals.each { |field_val|
                idx = result.index {|x| x["name"] == field_val}
                if not idx
                    items = []
                    result.append({"name" => field_val, "items" => items})
                else
                    items = result[idx]["items"]
                end
                items << value
            }
        }
        result
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::PyBuilder::Filter)