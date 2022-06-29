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
    rebuild 14
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6560b8b35dc5ed6a93dd029c7b13b9c1741d6ceabdc5e337fc90e947b7b8aa37"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a2635d8058e8ab13c5e9c3b64d8e7b30a5a1b10e688eb4d14bb90f526c7847dc"
    sha256 cellar: :any_skip_relocation, monterey:       "69901e40df9ed0c0f2f2a5fb4805cb12c37f370343a4207ae2f7b69898e9007b"
    sha256 cellar: :any_skip_relocation, big_sur:        "74034b16ed75190567ee0e9e8fada39faf0d6f21a0e76d49eda741c6abb6b14b"
    sha256 cellar: :any_skip_relocation, catalina:       "ceae2074da44802054ee3fb38ce1b91687e3c2f2e3f7e82c5e989fe939998aa2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8aa4b20c4d7f6df50685e56d01cebfe7b0e9c3bf9a2ad60df7e286a70b9123a3"
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
