# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/b6003ea5a22c07ad4dcac9c9ca578caf2251c31c.tar.gz"
  sha256 "02403df10b7d04d4806f31133c8acec973224487be4ac78d52e2642cfe912a71"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256                               arm64_tahoe:   "41457512e71c75cb2c7087dc017dc11484d8cb726a45b2024a050388accc759e"
    sha256                               arm64_sequoia: "9980e8c3f04e0cce2d93f32ee349f8005eb40fe240fa82e888cd05946cc28bce"
    sha256                               arm64_sonoma:  "693ff77fc156f8f38a368fef830fc87f0355d0e88f7f1eaa0e7cc65a8239f2af"
    sha256 cellar: :any_skip_relocation, sonoma:        "da18e35c841ab604ac8582512f4deb899559c02c39c6b2fa6082894096109b5c"
    sha256                               arm64_linux:   "3817a6576d943277e506052b63e15d8e9a04e62dee6faea47f0510ec96a8d234"
    sha256                               x86_64_linux:  "b33be4ae4792453cc0079ac0ce51b4d85382a400734d7960692845af77c24d47"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
