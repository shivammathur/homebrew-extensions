# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.3.tar.gz"
  sha256 "988f518407096c9f2bdeefe609a9ae87edac5f578ac57af60f8a56836d1e83a8"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "90ceafc8f9a4c91f9a16758a0f6d72d49d9a8e25d03cd2dc52da39947d9146e9"
    sha256 arm64_sonoma:  "17c15d1745b727cb927ce71fa7850c1a4eb217a17ecfe410dd3b72494954181a"
    sha256 arm64_ventura: "768faf8507a4b099ffc0912c301951e093388baf80044149638798c06de45f59"
    sha256 ventura:       "1118bd590d5f7e9a2da37280c6de2964aaca28923f41fae95a3d7df6126d46b8"
    sha256 arm64_linux:   "693e6395020d8cbc67c6b051ff067134b8d6d52edf51568081af231488dce9c2"
    sha256 x86_64_linux:  "f018e18f0e37052eef22077b864e0c83dbc9e881652ca0d23ad40acf0a68dc5f"
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
