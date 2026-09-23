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
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "75b1c5eb6a182da56d0b7cb859ae3d04f7e0f17fc6d82c96c27bf9b1a0fbed50"
    sha256 cellar: :any, arm64_tahoe:       "e8dce02f4410d3fe60d5067d7e203e7c92d56613d6686e44abea0d69be24e83a"
    sha256 cellar: :any, arm64_sequoia:     "826e4e050351e40c22369b1c345f25bd5e9e0f831c1c864ee5506262f49eb133"
    sha256 cellar: :any, arm64_linux:       "e786f50b8f55079edbc716e63c94621d6833a13d9462da78f3788dff9b7d1afc"
    sha256 cellar: :any, x86_64_linux:      "550e5da4b66fd2c07c66a73bda4193b6730ccb7734376aa27c77e56dd4f178f5"
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
