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
  revision 3
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "73503f1c53b91aef86f15edd6ee54cbc6c7625bea3af41acd3312bcbb43f0bc4"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "37be3eb4aeabca3cfedd8d22b2f3c06f9b6c4d0fb6157c5ef689abb31ea28a1f"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "bc556f63155a724876edbd40ae17c83eed21379791fc6a82b2054e23e219cb0e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "98705a2e0092d474cac8264210284b83a0057524ca2f6113a46ddba56d2043e1"
    sha256 cellar: :any,                 arm64_linux:       "955f87ae8c689259a33a56cda0ee1e4248b56600df88381d0128014c9e1cd3b0"
    sha256 cellar: :any,                 x86_64_linux:      "cae400baf4acc3fac39ed680e382b507cb6e2ee98a3b0ebd523673bf85270b1f"
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
    inreplace "php_apc.c", "ext/standard/flock_compat.h", "main/flock_compat.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
