# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/eb58f1bf89a2046564bf15b82b172325dce472a7.tar.gz"
  sha256 "27e1d58d9a9a27b329a9151e2c141ac2e251fad32381bd1c0eeeb61f7ec277eb"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256                               arm64_tahoe:   "b8b9c98878a4ceaef572e51bac3d8aef6b4e566c107a4a192f33a8c57398c0f6"
    sha256                               arm64_sequoia: "83e09f718f671ef995b9e84d5318e509222923648c9e39e9313e21524b04ac2b"
    sha256                               arm64_sonoma:  "4a74a9d63eb69dccda2c4765ce1ef0705dc5b6b51bc7149aa281c572e29d411b"
    sha256 cellar: :any_skip_relocation, sonoma:        "b33d4f6306fd2fc474bfb2f8404b382df773f362d051bb900d8ded6ce5f7770c"
    sha256                               arm64_linux:   "38a359ee1049d579ee92109e001a5e0e9e857a7ba1adf08716462bed7e317bc7"
    sha256                               x86_64_linux:  "e966c6c894dbecc4bcfa99b7fb2e7ef027e744faa63de72a55206525f985fb43"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
