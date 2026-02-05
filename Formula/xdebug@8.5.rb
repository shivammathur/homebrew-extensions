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
    sha256                               arm64_tahoe:   "99182081d6ac6426c76156b0254e711b1d2ac2abb0a74c69326034c72f21696e"
    sha256                               arm64_sequoia: "63ace38a497093b8b102c6ae3691186fbb6b53b318a6f927716fbf351da2a3e2"
    sha256                               arm64_sonoma:  "72661a24f6ef5450d79d10bd935ba81d2cf13730c4cf4368e7a3b810425aa3b3"
    sha256 cellar: :any_skip_relocation, sonoma:        "b755c177aa2122d5af005c8e772048bf941e662f00bb4ac8b12920cdd114259f"
    sha256                               arm64_linux:   "67002c6ad91f64b3f9ecff7aeeb2cd8d7811e539945b5e22fdd3a8f2ad6066ff"
    sha256                               x86_64_linux:  "35c79f4fde0c58a9ac573167c685f9fcd9c2b8c099045da397ea20a9f76676fe"
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
