# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT87 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "713851739c7300f53d917836841bc8a37d74baf242aa29e37b72fccd7173b686"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "54b226930c8260eceb6ed5ae6cbd6da08da34cdf8b43d53b14d55479810d1713"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "e64c2700fd6acc7d0c6e6de36c64669d697ff9ff83d3ab3fa546c763eb706404"
    sha256 cellar: :any,                 arm64_linux:       "bc29c33c2ad982c17f9c1569785bb8b6f22546fbe3916636a36c2fa51338200d"
    sha256 cellar: :any,                 x86_64_linux:      "1749f0e1e1aee980b3c63b1f8484fa7d732447afc30cb4cd5b092b32c204532b"
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
