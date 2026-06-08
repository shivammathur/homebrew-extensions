# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
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
    sha256                               arm64_tahoe:   "2c25153ecd883b420e78ced31810ea4a67d6c7d0a7e0f915fc5df47c2adbe828"
    sha256                               arm64_sequoia: "051340aa0a4fccfea9d3d99ffbf2962390f85a014fbb897c98bca5d6907656fe"
    sha256                               arm64_sonoma:  "2e5a4c04e7c06020b5b8485bd3d13415a424231ef67a619a5173c4b7aad45eea"
    sha256 cellar: :any_skip_relocation, sonoma:        "d20df1ec3c051a549292ba72c13eaf758873953f549a26bcac20a5c03f3885b8"
    sha256                               arm64_linux:   "942d96fee669b807199727759c68d8573b40dff7a446aece896ea101cbfba55d"
    sha256                               x86_64_linux:  "5c52984e8fb7b91a2c6797077104844a48f876397931bb277d66aef5c3155052"
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
