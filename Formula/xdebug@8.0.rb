# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.3.tar.gz"
  sha256 "988f518407096c9f2bdeefe609a9ae87edac5f578ac57af60f8a56836d1e83a8"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "0fb3306ed357842851dd87c4f3dacd41f54639205782c88b649e0d497c49568f"
    sha256 arm64_sonoma:  "117e2ce0259c9aea96ffc4e351d27c1621ed4addfcf11c73514334745c8b1ad3"
    sha256 arm64_ventura: "12d70f976919637312ad0eb9c652adf575a961a7cb4bfa94b01abba25b3846f8"
    sha256 ventura:       "22265e5c49992c4abc17cfe531317b28814fcc52868422402444ba28adb64aa9"
    sha256 x86_64_linux:  "0a42987b9ac7244cbb75e31b0d97c71933a648521ed4dbadbc4042ff401af991"
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
