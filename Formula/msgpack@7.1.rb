# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT71 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7853fcfb0e84dc8b9c110bd6363c79eb89e7b0b6430edd5ebad9500bdbce09d6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "97e149683e3292267e8c8654fd32b2ca3975a1fecc963fd16accadb451f7937d"
    sha256 cellar: :any_skip_relocation, ventura:        "50c1946cb6e95036ef86e0c25f1259b571894c2fc844a508d4fce406ab1f5efa"
    sha256 cellar: :any_skip_relocation, monterey:       "e4127e7f3b6d270eb8ad37f5d2e3d416ff1458434b5329bc4d67c506925664ab"
    sha256 cellar: :any_skip_relocation, big_sur:        "0387906b4ff3bcb607db4ef9357ba348be54b3e3ff925d2f6b38629d76415ca6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0cb98fea5e91f05492858bf5da2b648f2be25c5a463bfd3ef18c6df6ba1712bb"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
