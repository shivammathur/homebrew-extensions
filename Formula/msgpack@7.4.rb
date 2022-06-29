# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT74 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "543936f0f9ce9268fdbdbabd268dc486d84b4cbbe277818ff950feea1169dc27"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "334c8b4c7cfcced9e061ae850363cd36f2ad5af60f0254446bd2c3db719e3075"
    sha256 cellar: :any_skip_relocation, monterey:       "7248c157f217bc340d2d53951ed7375e244d3d82c35a3b3c634a79ffb60b9607"
    sha256 cellar: :any_skip_relocation, big_sur:        "0754aad2f063893f2da2e0fdfd8230ca86e7eb387ca71289fb9723767985df98"
    sha256 cellar: :any_skip_relocation, catalina:       "e66b93438dc456a63bde52ee4d8bc0ed02d41c4da4594c22afaf51e24f201e1a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5bcb89138368fd700276312400e4e7e41816947288984dbc5c935c2a306fe1a5"
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
