# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT82 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f2a14ab6c1d64752695cd29d98b6ea5da4274313fb5fe110719d282e66f54413"
    sha256 cellar: :any_skip_relocation, big_sur:       "27387323d6a8b1727914ff25ce3ef1b082fcdca51f7aa714fcdc5050bd3d16ee"
    sha256 cellar: :any_skip_relocation, catalina:      "f5686b58e182730952eb45ebe412d799965b2526874cd185201a8e3e6d6482e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "238e5740d0ad68d620f3486dbd075e90437ba7e3c58525b28aff6e3502de72ca"
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
