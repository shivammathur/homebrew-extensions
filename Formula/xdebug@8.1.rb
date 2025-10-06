# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
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
    sha256                               arm64_tahoe:   "89a4c905bbee28b64e848ddf26eb063133a65fa5a24cdbd4fa6b2b30906f4c24"
    sha256                               arm64_sequoia: "5a8286a8ab8bd053377fb9ceff0d697f566918dcaef90eb2b4f689f75e672c5e"
    sha256                               arm64_sonoma:  "2abf10117f8d136801c276f2d98bd591697199827ce132f6400bc07384f3298d"
    sha256 cellar: :any_skip_relocation, sonoma:        "904aa56f7cf475884d4a16f799cbd06ba085ae23d0664270739d4eaed95a1baf"
    sha256                               arm64_linux:   "a910fd01da962c3b9e963695eded215f69984325df8de28abe1d6f990dc65c58"
    sha256                               x86_64_linux:  "9f69c726b5bc79ac45b08c27b22beaa0569cdd2223bbe4067dfc72ece06a7e11"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
