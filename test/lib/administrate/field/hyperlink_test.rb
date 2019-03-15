require 'test_helper'

module Administrate
  module Field
    class HyperlinkTest < Minitest::Test
      def test_that_it_has_a_version_number
        refute_nil Administrate::Field::Hyperlink::VERSION
      end

      def test_it_returns_a_link
        href = 'https://example.org/test/location'
        field = Administrate::Field::Hyperlink.new(:location, href, :show)
        assert_equal href, field.href
      end

      def test_has_the_correct_partial
        %i[show index form].each do |page|
          href = 'https://example.org/test/location'
          field = Administrate::Field::Hyperlink.new(:location, href, page)
          partial_path = field.to_partial_path

          assert_equal "/fields/hyperlink/#{page}", partial_path
        end
      end

      def test_it_prepends_https_scheme
        href = 'example.org/test/location'
        field = Administrate::Field::Hyperlink.new(:location, href, :show)
        assert_equal "https://#{href}", field.href
      end

      def test_protocol_option
        href = 'example.org/test/location'
        field = Administrate::Field::Hyperlink.new(:location, href, :show, scheme: 'ftp:///')
        assert_equal "ftp:///#{href}", field.href
      end

      def test_match_implicit_http_scheme
        href = '//example.org/test/location'
        field = Administrate::Field::Hyperlink.new(:location, href, :show)
        assert_equal href, field.href
      end

      def test_doesnt_override_scheme
        href = 'https://example.org/test/location'
        field = Administrate::Field::Hyperlink.new(:location, href, :show, scheme: 'file:///')
        assert_equal href, field.href
      end
    end
  end
end
