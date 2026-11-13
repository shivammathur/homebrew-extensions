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
    sha256 cellar: :any, arm64_golden_gate: "1d4cd134b53c149af40010bbbc78428031d66e4d5c7553d657a4aebf2a93237c"
    sha256 cellar: :any, arm64_tahoe:       "8082f6a22741ee1465227798213b9e8349f40aa804d747f6c12f82bc902a6ced"
    sha256 cellar: :any, arm64_sequoia:     "5be58e742694c1a71e20be1c5c2df8910edd83023e24ac44b8814e6fa3a575df"
    sha256 cellar: :any, arm64_linux:       "0b09209b4db0ae69aae59af9ef830e9978785098aa0d31bd0115b876b4b97952"
    sha256 cellar: :any, x86_64_linux:      "653a5f0d190a96ebb4db23553f5fc7ecbaa5896eeb357e2c51913cc3168f146a"
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
