# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT81 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0RC1.tgz"
  sha256 "55ad876ba2340233450fc246978229772078f16d83edbab0f6ccb2cc4b7ca63f"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5be61c6278fd1534172c17eb98e8b0b3cf3d632ff1a243e7acab54c549dc44aa"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "bca99490b6f4ab4087990b53d7f2dd6bbf15b3fd44dd7d350913e82c4b1ccf28"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6560b8b35dc5ed6a93dd029c7b13b9c1741d6ceabdc5e337fc90e947b7b8aa37"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a2635d8058e8ab13c5e9c3b64d8e7b30a5a1b10e688eb4d14bb90f526c7847dc"
    sha256 cellar: :any_skip_relocation, ventura:        "89ccc8c2e22ebe2d7ffd6ebc60ab2cc02ae11e18ccf2c4752277ee39b399ea11"
    sha256 cellar: :any_skip_relocation, monterey:       "89e5b15d52f241a297d0a0e824aa5fd401c285b4e9134863cc21a9637bb6de9a"
    sha256 cellar: :any_skip_relocation, big_sur:        "74034b16ed75190567ee0e9e8fada39faf0d6f21a0e76d49eda741c6abb6b14b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2ee6a880495ebedc1b7b663b6048417fb5ac67eb96282ed540b47358ed68d8e7"
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
