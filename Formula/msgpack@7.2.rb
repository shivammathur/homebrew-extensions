# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT72 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6092c688b25adf2b00dfbd3289dd4f8017072299ac1cff11b082739e2ffd4285"
    sha256 cellar: :any_skip_relocation, big_sur:       "54c05a506033c87401b49264d93746d60af87538e8db7ac23587d96b56c4c76f"
    sha256 cellar: :any_skip_relocation, catalina:      "af05e5a297f01e74208a7dd3dde8624c07ca94a857fc9e47b0af39fd45589392"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e3a2c2b09ae3ad38b44eeed6d76aa7e88f65de371a328d27bb9f3be453a22857"
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
