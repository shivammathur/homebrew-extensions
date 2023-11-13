# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT70 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a958be921a263f21a8f0c73a2879fb117dd4234faea92e186f9984b696a1e4d1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "85c201e988fc6d9f98902a3a8bf0667f57e05f3521b4b1d30d8a52b5ee4c5f55"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fe799da3b02f81fd64ff164b1e845c3ef9f02392ff8519d27130dc1e43c1e4b3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2634eff0bc136270d6a02be269d445a3701e2c38cceb2d8350e821c9dc4171db"
    sha256 cellar: :any_skip_relocation, ventura:        "869bffd42e22e8a5af5e37a55bae8c2b23d66147d7ba3ae739c0d2f258595200"
    sha256 cellar: :any_skip_relocation, monterey:       "381822f27ef0e3c7fa92798392102d489058620008035c8aa588ea46586620a0"
    sha256 cellar: :any_skip_relocation, big_sur:        "9a832e8ccd88fbfefb802aff2be27c1db2949a67e5289cc883768ee9226c8a6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ece099348b7da19a18fc97dd6b6737b0682aa54c0c2b104d31f6007afda2155f"
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
