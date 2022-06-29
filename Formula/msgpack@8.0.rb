# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fa9fc2502b85f8dabdba29b1f1670328addc6b93bb4032afc7e4731847a529fc"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7a78c343356807f9c78de1d117e1ac231ca97e755d21261fed79b5e7fe907126"
    sha256 cellar: :any_skip_relocation, monterey:       "5e7525f77474768e537e8c4ae9efe61fb3ac88e39ae297570e6a5bb7c1e30f0d"
    sha256 cellar: :any_skip_relocation, big_sur:        "0d6d743ff28dd0749f83d92d2b3c84be0d24e46cbfe17790b261e663c6baf317"
    sha256 cellar: :any_skip_relocation, catalina:       "a5485b810567ac4ea28d711629cac1e82dc726d0392143bcfa6b260b0e163cc3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "28e9c5959fd625a2fc58d9d054fe9c66c5a018d20cf59bb3fe03070264ea0f47"
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
