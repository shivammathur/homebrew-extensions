# typed: true
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
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3a87846e79a901fc58d36b004225d8a3e9e999ff04f39f958f0a7e14dc081c03"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0f056d9c6191da9a00bdb299312f80a4c9e905a8405c2ab43be7ca6629f3cfd1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e5f4416d888e8d045c60a88319817e37f15ae0085d56ea944f3d2a495552d5f2"
    sha256 cellar: :any_skip_relocation, ventura:       "7799299f26f5f8cdbf7c3e4ea73b68598f9a3c30e5e701697938126bdc4cae19"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8cf47dce1632154545ec06e8e677aaf7328ddf4ef5fe7944965513457d480494"
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
