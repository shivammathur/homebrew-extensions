# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.3.tar.gz"
  sha256 "988f518407096c9f2bdeefe609a9ae87edac5f578ac57af60f8a56836d1e83a8"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "6aaeb4d6967c3f89e81e9e62edd0341cf9ac201ff481be086200adcb035930cf"
    sha256 arm64_sonoma:  "07ff4fe9a17bb258554e3977ee647d33fb90c02301034ea25a8c3d73cc7dad51"
    sha256 arm64_ventura: "3aaf053fddf7d28837e7ad70383a055c00c9b3a5af0555ab590a60d8a101963d"
    sha256 ventura:       "45f5593426d324c104ea1ba739353ef99cea3ca849915e5e22ab4430e2e61324"
    sha256 x86_64_linux:  "f38b07ffeb812f963251ce074cc7806122837e43b75a2f143eb83d54e31502ad"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
