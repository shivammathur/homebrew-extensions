# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT82 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "352badf6d05777c080c85a2f9b4581fbe402cef44c4c9f21ddac06f644873010"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6437720ed0ee2be4117b69ee1d458e56b2abddc184e94754cd01ef3294dc65b5"
    sha256 cellar: :any_skip_relocation, monterey:       "2524aa424311292b693d209235a8e4ab6f7c12325405f57dd11fb91eeb17e284"
    sha256 cellar: :any_skip_relocation, big_sur:        "b34b671f315215dd1749931cea6cbdd77db3fc07a13d65438ee901027b5d7369"
    sha256 cellar: :any_skip_relocation, catalina:       "60645060b36a921e905811c2eee0b53fd1444ce6d394fc4c90684b4aa5591c94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "51537e16156694884d177fce2f5b48aa04184618f8899f9edea08611735eadfb"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
