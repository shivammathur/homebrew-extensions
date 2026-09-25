# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT86 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  revision 2
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "853c07f5ce82c77ca736799797cbfb9fcce9b874aaf1b0230f96a450d7e1e1b0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "030551292aa06ef5e26dc6628ec09e1f6bbddaa1618ca067811f92bdbe01609a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "2748b81fabd6ae844608641fd56a65964386567c1f6cdb2ab1aa219667c1dbcf"
    sha256 cellar: :any,                 arm64_linux:       "a63671253345474e1f4b94756b590079ee1c49d7e14c99e44b96c06c8d26bf8f"
    sha256 cellar: :any,                 x86_64_linux:      "71a8e99ea6d65d121112a42e1027544e04f0cb87c87888a3dc0a533a36c5122f"
  end

  def install
    Dir.chdir "apcu-#{version}"
    inreplace "apc.c", 'php_verror(NULL, "", verbosity, format, args);',
                       "php_verror(NULL, verbosity, format, args);"
    inreplace "apc_persist.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE();"
    if File.read("apc_cache.c").include?("zval_dtor")
      inreplace("apc_cache.c") { |s| s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" }
    end
    inreplace %w[apc_cache.h apc_iterator.c apc_iterator.h], "XtOffsetOf", "offsetof"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
