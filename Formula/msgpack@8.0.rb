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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fa9fc2502b85f8dabdba29b1f1670328addc6b93bb4032afc7e4731847a529fc"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7a78c343356807f9c78de1d117e1ac231ca97e755d21261fed79b5e7fe907126"
    sha256 cellar: :any_skip_relocation, ventura:        "5c925d1543fd6efd93e73b9473b1eff03166cbd2559e1383249606e06d636382"
    sha256 cellar: :any_skip_relocation, monterey:       "a1d4df840477f27be0e94d0caebe1bc7caa523f3bc39eb25ef76cd5f279be5b2"
    sha256 cellar: :any_skip_relocation, big_sur:        "0d6d743ff28dd0749f83d92d2b3c84be0d24e46cbfe17790b261e663c6baf317"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ac84d36c3c93d2b9408992ea8eaef0ec8cb7a12dcf3adf1743a9406135d3de49"
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
