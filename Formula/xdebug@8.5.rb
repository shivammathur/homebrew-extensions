# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/cd952dcb5e2cc5c1960f82c0485e1f85e8c96d67.tar.gz"
  sha256 "cbefae0ebf839603a339f87d28c96920e542f541c61dee9642c3df94b5f0f54e"
  version "3.4.5"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_sequoia: "4f5cab666931a4be04f493ee76aeef8708d6779a94d4823a04a39c5b2a398766"
    sha256                               arm64_sonoma:  "5817f3f9f87d385329c2e08b6fc253bb9194893ea0537ade375d33dda5e17591"
    sha256                               arm64_ventura: "a1b744ae29bf8175c4084855329d1bd3b8c984ef0be9bdebb7be7e75395ad4b4"
    sha256 cellar: :any_skip_relocation, ventura:       "991d0e53caebb90ee68082957c48a4f049b3c3a33b9b1c2bed1adf9659b75797"
    sha256                               arm64_linux:   "91614d2e34a0e1a03edd09635c2b2f68c69f2d16bf1058041f5a88350ca5d254"
    sha256                               x86_64_linux:  "c9b4ddc81c14795400ef88ecf01cfa947f0c61cca3f47f6545ad2789a79569a1"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/compat.c", "samesite_s,", "samesite_s, 0,"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
