# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT87 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  revision 2
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "411a486c833ce491ce4c003ff5b22487452b9c749c17ca4f60c364d739672c0e"
    sha256 cellar: :any, arm64_tahoe:       "38ddf82ac785b106ae161bb9a12ac4d849116c352a83cf6a4e768d932adff5d6"
    sha256 cellar: :any, arm64_sequoia:     "fd68042c3c67042ab19e9ca27e145f8d60cde794c96da9e5a6ef671f5fec25f7"
    sha256 cellar: :any, arm64_linux:       "839520b25c32c24be1d26dda3c46ce4f1df1bd84be617627070db9fe62bc0e87"
    sha256 cellar: :any, x86_64_linux:      "11d3f095ea9c2f5a173d16c5056c3a1d533346006368b8384f6db03e1ee7feab"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Utils::Path.formula_opt_prefix("vips")}
    ]
    Dir.chdir "vips-#{version}"
    inreplace "vips.c" do |s|
      s.gsub! "zval_dtor", "zval_ptr_dtor_nogc"
      s.gsub! "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
      s.gsub! "zend_parse_parameter(0, call->argc - 1, &call->argv[call->argc - 1],\n" \
              "\t\t\t\"a\", &call->options) == FAILURE",
              "!zend_parse_arg_array(&call->argv[call->argc - 1], &call->options, false, false)"
      s.gsub! "zend_parse_parameter(0, 0, &argv[0], \n" \
              "\t\t\"s\", &operation_name, &operation_name_len) == FAILURE",
              "!zend_parse_arg_string(&argv[0], &operation_name, &operation_name_len, false, 0)"
      s.gsub! 'zend_parse_parameter(0, 1, &argv[1], "r!", &instance) == FAILURE',
              "!zend_parse_arg_resource(&argv[1], &instance, true)"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
