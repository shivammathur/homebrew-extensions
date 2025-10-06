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
    sha256 arm64_sequoia: "51eb8c0defce92fcae0c9cebb2c294be1fd445e0afbe24a43fee256b7f6006f3"
    sha256 arm64_sonoma:  "ce62cbd5dc16f4981f0c10e7056d84cc7946e2247d6e5efaf61ac6ec03469a93"
    sha256 arm64_ventura: "4209026c060efedc5c7b0b05df52f949c1247906b4dcea2a65c85cd04fc24600"
    sha256 ventura:       "f9212190d5da7f307ce1ff5b3499ccc3165615eca421c4966d9e8014216bd3af"
    sha256 arm64_linux:   "5d4c44730f5f841f229beaf5823ebb395d0d23ad0e7342fa3a0f0c7930a75c2e"
    sha256 x86_64_linux:  "870f8f09b2336c4e506768bbc5397f78f2c4de27f1c00365f09fead0d3e45244"
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
