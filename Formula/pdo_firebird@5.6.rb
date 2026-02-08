# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT56 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "31da852f27a4ebc1319dcc3f36c7b5e0a6ba90c0772e4d528e2402185acffbdc"
    sha256 cellar: :any,                 arm64_sequoia: "39020cd9aa317e031f3a71e281de81478ddb268dcc2f31518694feabca9970ba"
    sha256 cellar: :any,                 arm64_sonoma:  "aebabbe14850c68ad68441cf8797772b27d04e68d1e6793a90d252426e5e9c74"
    sha256 cellar: :any,                 sonoma:        "f1faad2abeda8ef41106dbff969fa88b7bdfca263f9cf744d3e5edc2431e7ea7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "84c3ca2a4e977b31bf77e4129c446f21e16a5ca43719216e4752ea3e05f26c59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0458be32e825e562dfbba7f0bbd5b9b88546d9c017ff9d3897f197d40dce873"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6cfe49e294414185452ec89bad39b1bd42cc72c9.tar.gz"
  version "5.6.40"
  sha256 "c7aea2d4742a6daadfa333dce1e6707bd648b2ed54e36238674db026e27d43cf"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
