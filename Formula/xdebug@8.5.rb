# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.1.tar.gz"
  sha256 "8fd5908d881a588688bd224c7e603212405fa700dc50513d0d366141c27cc78a"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "a5ec3609ff59356217cc8377f769415417eea834a2b26baf6ead25aa40e84283"
    sha256                               arm64_sequoia: "7718370d7488298c2b9472f867eac5ed823fa2cb5b41183c638bb3d3f4a17b8b"
    sha256                               arm64_sonoma:  "f38b5dfe431adb47b7be9a5ea395ece7d6d3bf5b84a2ce554a45e12dccfac4d9"
    sha256 cellar: :any_skip_relocation, sonoma:        "f696305a5997806c2c9fcb5a4c2ec33acc5455d02175975993694534d53b7323"
    sha256                               arm64_linux:   "843b1773bc99af7111e20b188a065d03121a65dc749716b05ed0b72d7713008d"
    sha256                               x86_64_linux:  "dd507a11f692269faa180b133ebbc6cb9cae1160b064416276325cbca2b0493b"
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
