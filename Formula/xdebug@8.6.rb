# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/d231abe0a0b04e913a28ceeba80001e7cf3f2541.tar.gz"
  sha256 "5730c4c398e117f3454e683e2784ee63ac78ed1787caeb097c3dd28359cbd8d3"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256                               arm64_tahoe:   "8fd63db38533f96691fd272783e2e3b6c954b2a4ea5c63523936db906bd027ee"
    sha256                               arm64_sequoia: "ac1c1cad41236ca7e9d0ac965570b8e93c68bb91addec9ae4bd9fa9b697ce559"
    sha256                               arm64_sonoma:  "16df14f0ee8891c3535320542935e54a115092833f9aafed7939edc7de888e26"
    sha256 cellar: :any_skip_relocation, sonoma:        "d0d56bbd24cb6ba9fec695a2a680de756acbc9da424887aa1400d3458dcc25d0"
    sha256                               arm64_linux:   "ba721e6cd9aef9d1a040b6a2df0f3eb643ae86cec8d0825acb82f3275e28f524"
    sha256                               x86_64_linux:  "4504b089a80005b1c32f3351b5e10e85019abf9b89b4478df37f786c499e067b"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
