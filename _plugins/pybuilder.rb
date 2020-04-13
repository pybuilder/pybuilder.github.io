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

    end
  end
end

Liquid::Template.register_filter(Jekyll::PyBuilder::Filter)