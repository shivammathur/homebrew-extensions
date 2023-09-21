# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/80d4be0522766eb5394f15528fd616ea7b96e62f.tar.gz"
  sha256 "08de489c0a9bd4004b36ec400ae0e9a3369bdcd00f913cd5e2f32c02c4f63345"
  version "3.2.2"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_ventura:  "8aecafd8759e0091c86b417e92c5eed2cb9bf5059b5ad30725e7beb9e23117ca"
    sha256 arm64_monterey: "37a2b745996aa797c653ff4391cd0b1210f2758829985c55bcec8a80ed8f7974"
    sha256 arm64_big_sur:  "a6dafb95a921cb0afd91c768da3e8aa82c1395ebd3c471d71c7f7e515b28521f"
    sha256 ventura:        "fc9bbdfd97527cf9c0b9c43b96e49184037b9e1782b5c2d5211121516b641941"
    sha256 monterey:       "3062656e7aecaddf1611c531269816f4219451570d045ea9b7c36298931700ee"
    sha256 big_sur:        "a5a3651c34271db9d36d827307664d1a6f41ba11354c62457837c32ebbfecfb2"
    sha256 x86_64_linux:   "adc61bb19b2c50e7f99e9c3e143446dc0aa28f4f38cf01be7955195911b02f3b"
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
