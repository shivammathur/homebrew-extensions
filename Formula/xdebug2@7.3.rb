# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class Xdebug2AT73 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2.9.8.tar.gz"
  sha256 "28f8de8e6491f51ac9f551a221275360458a01c7690c42b23b9a0d2e6429eff4"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "1d295a3e75d3e535bb62e7469847b6ac9c3a0942cddbe1b9557f432a4bca2fad"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b82f549363c7e59a6b9977c65723b38c1f57d7555a2015a6c916630c68698a4b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3214fee827cc47ba071faccac7271bd047fc5b676a8ab5c0a77fa5b0babbc3ab"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "800523c7227a1c6b915a5778198da29e109327a49443d165d56c287bcab0bacc"
    sha256 cellar: :any_skip_relocation, ventura:        "9795a94922810a7acb64b3aa7332794299dab7dbc8955e9f12a07d5ac2bad97f"
    sha256 cellar: :any_skip_relocation, big_sur:        "9c9bcdf033eb9d821a53849f54117880899c867b4504514ee66e901da3fd5f8a"
    sha256 cellar: :any_skip_relocation, catalina:       "a37b0fce364966b3a5b441148126b5b9102ff4e954a3dc7fa896548634615284"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "795d7b21d8f18c1fdcf26ef3712f282195b33f79033d4aee80b6e32b5380db24"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "264910ca84f54ede7ef5a78233d12f5f1273b9ad2e14623accf88bdd261db90c"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
