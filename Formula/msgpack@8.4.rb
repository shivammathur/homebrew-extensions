# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT84 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c10af40c5e511f7467f2cdac760731941eb7178efc02d06918e4d25c09d88214"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0fd5ae7f30cc2ed0cd0bb2610f4e391414b9b31481666b0e98e45523f827bfc2"
    sha256 cellar: :any_skip_relocation, ventura:        "7fa8b4b7b42aa230790c89b2afabb98dea1674e609ddb8fd63bf96adf5e6f8f6"
    sha256 cellar: :any_skip_relocation, monterey:       "a7407906ab3386a13646c7a08bd6a84a3d277de48bce2747383f604ee4208c83"
    sha256 cellar: :any_skip_relocation, big_sur:        "2998630bfe061e8a816a4704b57b75d0466470cad0293287ddddd2b291dac007"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b37ec7ee5d497ae8afa8a696b3812745db7e8a2bb8bbc7948417ea68b438068b"
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
