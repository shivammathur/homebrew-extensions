# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.1.tar.gz"
  sha256 "8fd5908d881a588688bd224c7e603212405fa700dc50513d0d366141c27cc78a"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "87cfd63013d94fdd010f312f0b97f83120a99b6edb17fe8be74ef956119fe196"
    sha256                               arm64_sequoia: "87273351d92c9208ea7a6c964c8f83af0ec64a0d0de772ebf4c4c9a62279d18b"
    sha256                               arm64_sonoma:  "841fee660fc4714ce2b2a4232f2213f8d62fd670f2b65c03e457a7ea7d90c8a2"
    sha256 cellar: :any_skip_relocation, sonoma:        "21aa4dadbc56222867caa3cc32c8c9cd95ecafed6b8b178794343eab3f9bcca6"
    sha256                               arm64_linux:   "111728461cf1cadd58cce54d27f7b8218244694658bf1c632a51288d5e7fae0c"
    sha256                               x86_64_linux:  "a9bb32c608fbf74389d4b9bb7e1e01123e705be018c80f3f056014addebc442f"
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
