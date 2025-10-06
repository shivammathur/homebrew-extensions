# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.6.tar.gz"
  sha256 "4ac1a0032cc2a373e4634ec8123fc6e1648ca615c457164c68c1a8daf47f4bcc"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "cc063d1f0570a3836230defbda29cc0313e3189e984d4d25b60cf134a8c30c9d"
    sha256                               arm64_sequoia: "508e647f75b2f22eae83379a674d4634d8dd6d3e9ad7d633a28932f0dfd88ebc"
    sha256                               arm64_sonoma:  "cf01b4614485f13e073ff6fdea7caed54e5f5a93fb5c27b3091adb4f3b88027d"
    sha256 cellar: :any_skip_relocation, sonoma:        "a102ba13c0e7d8f334c7febd95442f29423a9816e124222d8c6406c15e92456e"
    sha256                               arm64_linux:   "64851ad951e7ca5138f650ca4f205d26f2dd27c172c7fbeb149dbc1c2ceb1d8b"
    sha256                               x86_64_linux:  "0f08259e533081f3175977b460422d43db3e38bc84c45b70ba17d93e4e34cc19"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
