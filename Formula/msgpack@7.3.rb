# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "66a196a29f8f564478039db591c7199370e9fa2a8a954a6d9883055d16a9d23c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "42360c2d8652e29c06ac9f9dbd445bdbf124feecc91dd95ad5835b5280e2d8b4"
    sha256 cellar: :any_skip_relocation, monterey:       "18a9d7a499b11e0513b37e3fea4c5148a8beadade6d2245465f68cfd01cd5883"
    sha256 cellar: :any_skip_relocation, big_sur:        "8fdad3e50928455921fff01c8e8c8ee18da17b187b7ef10ce438c3691e037452"
    sha256 cellar: :any_skip_relocation, catalina:       "e274fff3476b853436221787211178e4fe7e3bad44a3862706ac3983ad68d0cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9a056a5114c0d6aea7db59f860db5c54c0c9dbe53e34faf45518eb53f1246e36"
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
