# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT72 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "e5d04c2d01c978cee3f3c6d3d73ed85befca11ee561a0e0d9ef857c29682b1d4"
    sha256 cellar: :any,                 arm64_sequoia: "d1ebc76b54eaba8fba251bba38987e58debcccf0289f0bd3bd3bdd02049eee02"
    sha256 cellar: :any,                 arm64_sonoma:  "240ffa4887bb3c48995fe75ca72c4dbd28ffc54335fc141eff794a904beaefa8"
    sha256 cellar: :any,                 sonoma:        "442050916aeebe5fe09d4c6aadddbfbf48cd91a1d6b3c5e016c8ff9176461b87"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "487d2f34cc48f5a2d4e1be3607b9a330e9a75cb9c2127b31f937d78f6debd681"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c80b6d7bf588e49c6d0b7555e67cace2face77a3114dd48abb3ae01470a4a8f"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2d50adb80c207633b15d0e6c37d8d26f35cdc3e6.tar.gz"
  version "7.2.34"
  sha256 "ea6bec47b26676940a078937b93a5b16adefef8dbaeeacaa05daa43f07bffc7d"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
