# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.0.tar.gz"
  sha256 "b10d27bc09f242004474f4cdb3736a27b0dae3f41a9bc92259493fc019f97d10"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "16203dc654f9f4ea535f6584a6a7fa57be81420955d77c7d50ea6aae8f055c36"
    sha256                               arm64_sequoia: "3ecd234dbb4a2200ad62e0e55f984bd475190062d767db12dc4bf3b0da4ce4c9"
    sha256                               arm64_sonoma:  "612eb0cef365938b7aff5ee17473cb59b2b4aa02158dcfc704ab687d094202e5"
    sha256 cellar: :any_skip_relocation, sonoma:        "52ac5c23e57decf22037f38e1052124bbcc0d8971bd862110c06e68587b3e214"
    sha256                               arm64_linux:   "359096b392133cd26937ae3cdbca3054f51be8ff976fd398e7c719bfba9c12fe"
    sha256                               x86_64_linux:  "e274be77f434aed7443c81fc53c5e151a6d1c8b78d402697c738f9e5b51fa2b3"
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
