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
  revision 3
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "a4195adfe3be9af49108e186f7de3a0cc06471636c94d2555595886345a6cc78"
    sha256 cellar: :any, arm64_sequoia: "921f8495173dae6f5cbc60689ed22a9961b22b220f5e81dd87bced5de80a3f73"
    sha256 cellar: :any, arm64_sonoma:  "205f83459105cdce0793ab44704f121aedfc93e855b7148a366bc45972de7fef"
    sha256 cellar: :any, sonoma:        "337c69ba3437a1762809225d7cff730d28cb90f8e0cfc90ab72dfa36a4f2eae6"
    sha256 cellar: :any, arm64_linux:   "c2b04dfba9912c8384013bd0183dc896943bbcfa76700e13649fd6367012fafb"
    sha256 cellar: :any, x86_64_linux:  "c61e7b88d2f4760dc027201ba9f552ec6eb180c3f3c5200145ad49a387c026ef"
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
