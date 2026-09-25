# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT86 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  revision 4
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "6bb3071923c6b13c36a720cfc1d94edb36f8c146ad47ea5c4b12edf1980ec3b2"
    sha256 cellar: :any, arm64_tahoe:       "9b3645e7d67a03be5f981b322eded87bdd88da8a5c6521e3157431884f15cd4a"
    sha256 cellar: :any, arm64_sequoia:     "284023d7342aaf7be05756a68ef7e88dfa5003103d52b202cf5f3eafba8a4db0"
    sha256 cellar: :any, arm64_linux:       "09619d107169d4415b0c2b121ee512767a873efcbaae3c7421e7f21dad32579d"
    sha256 cellar: :any, x86_64_linux:      "948b66cb94d7ce2442a64ab6f0b2f4f1604ccf829b4734c4087f5a522e7ea820"
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
