# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/bd9f063cc6a5c42bbd7f41fdbe5cad7b6f5f8fde.tar.gz"
  sha256 "145049882b6f190a603d902ef87e18ae3b004ee1ce7110f246364aa4e2e356ad"
  version "3.4.5"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256                               arm64_tahoe:   "e82bbaf7a10a715da48d9a8ac5539d6a4fca9ca46475f95ff34c42accd3b5270"
    sha256                               arm64_sequoia: "8cf35bfc05dc36b7b2b604c28eb379c5fc74aef9b9fdc21efd623d0dbf489cfa"
    sha256                               arm64_sonoma:  "1e894c29d8b352ac4c674096fb2375f77d234842b256b4c1e24f5f49654da9e4"
    sha256 cellar: :any_skip_relocation, sonoma:        "97eec85b2e370ffea112d3cdfe03faea3229b1ae3e5a4fb5efc6b05ef881868a"
    sha256                               arm64_linux:   "7877a97d073db47bfe9d5b8fd6577bb8ef9bed97d45c63473f6cfe6736fd85e5"
    sha256                               x86_64_linux:  "d92822baae2dec738410e69bea0718f11ebc84c34201e46291008d5cfaf23d0e"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/maps/maps_private.c", "xdebug_str *result_path", ";xdebug_str *result_path"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
