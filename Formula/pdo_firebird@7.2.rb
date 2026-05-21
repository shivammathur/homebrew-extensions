# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT72 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2d50adb80c207633b15d0e6c37d8d26f35cdc3e6.tar.gz"
  version "7.2.34"
  sha256 "ea6bec47b26676940a078937b93a5b16adefef8dbaeeacaa05daa43f07bffc7d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "c6e39c07006a764d3f21b7a37f9da4049055dd66f70bc53e5c5fc0cdad8f2e2d"
    sha256 cellar: :any,                 arm64_sequoia: "a38acd6e103e81a406261989aae98e139a41b466c3a8c89257b6bd660b17075e"
    sha256 cellar: :any,                 arm64_sonoma:  "4982d0d7a37f11c63d90e5044d8a5cef22841ee8105287de0e11bf34daf2a0e9"
    sha256 cellar: :any,                 sonoma:        "56565761c97281b80b21d07e1b51e818b78a99aeb09bf930c431c1b89ac83c60"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b86a194387cf674e296762fe6f86b444cd80133a0ca46fbd43c1769e8d80b101"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e6b63c8addf02204001f8d1096554af886af00b02ed4c14ddbbcdda6b0d51f80"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
