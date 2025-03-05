# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT82 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.13.3.tgz"
  sha256 "e4dfa6e5501736f2f5dbfedd33b214c0c47fa98708f0a7d8c65baa95fd6d7e06"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9ea7a455a3852caa0774b278fb8fddc47695888da57abee6fe34e91b910c88ea"
    sha256 cellar: :any,                 arm64_sonoma:  "429e213aca1af1261225b56103bef4cde2865399a6dcdf32c293d588a8b53e37"
    sha256 cellar: :any,                 arm64_ventura: "cee0e23972c46733227105d6f5bed5abc812bfdad9b8221601e0f1a7fc03c6be"
    sha256 cellar: :any,                 ventura:       "a2fc4c8bfca27635878a418bd77d34ae5ab4b0d81e8e8c8a399ccdbcc769159e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3ae2aae719608266de698131342684b31fe2b0f25fb82dd807c8bea106b04c7d"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
