# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.7.tar.gz"
  sha256 "6959726ee2bb99efd660796736801b198ec0847b6360230a8143ad5e2d2063c2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "d0d225d58f91243b7f4336a53ecfbfa8d6e0db1bdb110e4bcc72fdfc448020ef"
    sha256                               arm64_sequoia: "949b41ff3f29479658c6ad90e904670333e54871e739193de2c6b6a7206f6063"
    sha256                               arm64_sonoma:  "85694f6b251bce188604a40d350872890de7bd1a3a7c459fb3df852d213bfcf2"
    sha256 cellar: :any_skip_relocation, sonoma:        "98d1c8805f846aeb903a143950417bf1699d8d0a4edcc7e0c0c91bb8d77b4553"
    sha256                               arm64_linux:   "22ffaf2541364a40119e5594aa051810a84434a56ce6de6324cf7d9a6bb7b215"
    sha256                               x86_64_linux:  "06b0fe75fdaf0875338f878ac6701cf27e7b04e9dfb9d0b10b3f40e417da1444"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
