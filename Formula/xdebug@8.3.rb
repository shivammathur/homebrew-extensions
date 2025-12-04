# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
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
    sha256                               arm64_tahoe:   "2f1b3b27b888e8532c507330ffe46f73a6ee874daa92412f637a16a6562e633a"
    sha256                               arm64_sequoia: "a40f74898bcfedf84a391d121c76f9086e3054ddaebd5fa8568c2629642bb645"
    sha256                               arm64_sonoma:  "6a3c090c533457e7ff512c3b684377c9bd85292da39a6b09179153c17178cb42"
    sha256 cellar: :any_skip_relocation, sonoma:        "53a73ad9473952bff0ca24e5c47840479f1724ed87ed364e52738d8fbab12661"
    sha256                               arm64_linux:   "1f85401c2f00a0b839191e7d9ff95c43d49443faf575df16f93c8697bf89aec9"
    sha256                               x86_64_linux:  "020b2e53b6b3afe1fd543b5b25974d92e543ba0433333174a4d1292942df5a98"
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
