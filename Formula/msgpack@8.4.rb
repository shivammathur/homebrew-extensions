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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "25d785afa2f1f170db8afb68458043c8dd17142ab1882c7b153816de72ff6347"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7208d4b2a75561e546956e23bb02687f5dca5fece814b3e9994def8717920bfe"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9c4af27a9d2a22b1d35639887a6744cb9f8d21b901caa4f484fb05f7e40f3f01"
    sha256 cellar: :any_skip_relocation, ventura:        "67356dc4c9b8ca624438394404a38f9af16e80353ee5dd1f71a5c22c75955cec"
    sha256 cellar: :any_skip_relocation, monterey:       "84bd641418f8e77ac46f53b9a3256c1b6eb9455387850cbc050c3f36cfb418eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8dec7e849e4991c416cd8176c398d5452642f95da782714b14cb72c94650b459"
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
