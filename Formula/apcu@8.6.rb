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
  revision 1
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ecc4a8fd857358b20f1291860386dd960676e8997196aa6916cdcf595cde5d8e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c7b1b2419333ee2db55683e2cb2c0a0bf010709d81514cf46315b57ce3ce62e6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ab45b5b91fb4a8968b986d55a1b8486a06c1886e784fe2f56b0c65b2d4d04142"
    sha256 cellar: :any_skip_relocation, sonoma:        "43bf41db57930fd6bdeef5901d535567935460212a54fcdfefa2208e854e7c72"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "981bdc183f4f678e54b959f44514a2e84355d9ad760711222ddb7cbe1f4448fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "14aa9c631f627a72bcc3630d769b0f95f08103476ed68bc6fd02529cc6a5775e"
  end

  def install
    Dir.chdir "apcu-#{version}"
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
