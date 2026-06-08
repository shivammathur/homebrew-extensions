# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.3.tar.gz"
  sha256 "954e56021668121ecc50b92d2ad1ce945f22ecf81ffc5bb5835219485b12ef5f"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "eed1663299e782cff0e38ae3b96402e7f1585bc4065bed6ba02ace1108bfdcd4"
    sha256                               arm64_sequoia: "ece248eb211b8f71a615f3cd84659c27c7f48d440da114ab91106d43284dbcbf"
    sha256                               arm64_sonoma:  "c648f2a92e7f1995fb95b46981b16ffa9048c4507625f12999e247e7a3b58581"
    sha256 cellar: :any_skip_relocation, sonoma:        "068070ccb2080d8ce7a312fc934dfe3c6d5901c6527a20fcec783f78e619b53c"
    sha256                               arm64_linux:   "1aed2b9b338694537d5b186b190e7b569de990567f4ef25206a04a8d84299f99"
    sha256                               x86_64_linux:  "1fd9e359b724dc7dfae9cdd56d33e3df607c580905039c6fb21c2cd666ecd05e"
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
