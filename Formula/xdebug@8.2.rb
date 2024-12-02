# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.0.tar.gz"
  sha256 "ea3a066a17910ab9be6825cb94e61bb99c62d9104e2751f15423d2b7903bafdb"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia:  "e316c6c2ad85242a566b5c99d02f1dc0d8374f263ee2f025ccc2adebd5084e09"
    sha256 arm64_sonoma:   "1091fb4dbbcdf3865f793db85a5009595fc43a1c6a1fa8013b73c8e2c70d1264"
    sha256 arm64_ventura:  "47e70d764b2d814048c722c6c43964146ba810c1a4ce2170c47bb7293b2a4088"
    sha256 arm64_monterey: "c2071446f2dde3d48f39cb9260432d7d0db6692ff9fca94ce5cae36ee550b211"
    sha256 ventura:        "db2cd9584cf6b3c3932a7988e216d7aa0d35ac8faf0fdfbd8e4444f41932eeba"
    sha256 monterey:       "c4cff9dfd9b2e5356eae3e4d8a37231f2a7c3c14a1bb38e3d846c231a89979f6"
    sha256 x86_64_linux:   "27e68a97a4ccf65375b5006e8b998d906559f1112b140b826c9b6fbb54efdb6e"
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
