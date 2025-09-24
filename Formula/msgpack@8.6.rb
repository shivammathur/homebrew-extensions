# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT86 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "947077dba3696b8ab1f3f7e54b21ac42134042cc7f57895d6dc7dd1531f0b1f3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4e2899f3b7523bee602c18d6f68ba585fabc29864aaf5f19071a3d181ac72605"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0eb429bb90c7adb185ebc5822d99bfe680e53317349859360b03436f66dca132"
    sha256 cellar: :any_skip_relocation, sonoma:        "8a0b226bcceeda55a8256630875f4ce219a0b3f0233c8d0ac836c63805840c85"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ab420a406514da7b8ed166f2bf3582b3f0ab4d01ca9eeff0eb91afc9d65638d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f5beaeefa151c4faa83e91de6877e3956451b2e33e7c521ddf03b0636dd11f2d"
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
